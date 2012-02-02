%w'yaml pathname tempfile'.each { |i| require i }
def require_all_tasks
  %w(temp_convert).each do |exercise|
    root = ROOT
    exercise_task_path  = root + "exercises/%s/share/tasks.rb" % [exercise]
    exercise_tasks_path = root + "exercises/%s/share/tasks" % [exercise]
    require_lib = lambda  do |file|
      basename = file.basename.to_s
      ext_regexp = Regexp.new("%s$" % [file.extname])
      libname = basename.gsub(ext_regexp, '')
      libpath = file.dirname + libname
      require libpath
    end
    require_lib.call(exercise_task_path) if exercise_task_path.exist?
    Pathname::glob(exercise_tasks_path, "**/*.rb", &require_lib) if exercise_tasks_path.exist?
  end
end
def execute(command, env={})
  tempfile = Tempfile.new(Pathname(__FILE__).basename.to_s.gsub(/\.[^\.]*/, ''))
  Pathname(tempfile.path).open("w") do |fh|
    env.each do |key, value|
      fh << "export %s=%s\n" % [key, value]
    end
    fh << "%s\n" % [command]
  end
  bash = "bash %s" % [tempfile.path]
  result = system(bash)
  test = block_given? ? yield : true
  raise "execution failed" unless result && $? == 0 && test
rescue
  puts YAML.load(<<-EOM) % [tempfile.read, {result: result, exit_code: $?.exitstatus, test: test}]
  |-

    When executing: 
    ---
    %s
    ---
    Got: %p


  EOM
  raise $!
end
