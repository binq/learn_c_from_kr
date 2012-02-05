%w'ruby-debug yaml pathname tempfile memoize'.each { |i| require i }
module Utils
  extend Memoize
  def current_excercise
    Pathname(ENV['PWD']).relative_path_from(ROOT + "exercises").to_enum(:descend).first.to_s
  end
  memoize :current_excercise
  def require_all_tasks
    %w(temp_convert).each do |exercise|
      root = ROOT
      exercise_task_path  = root + "exercises/%s/share/%s_tasks.rb" % [exercise, exercise]
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
  def execute(command, options)
    input = options[:input] || ''
    env = options[:env] || {}
    prefix = Pathname(__FILE__).basename.to_s.gsub(/\.[^\.]*/, '')
    script_file = Tempfile.new(prefix)
    out_file = Tempfile.new(prefix)
    Pathname(script_file.path).open("w") do |h|
      exports = env.collect { |key, value| "export %s=%s" % [key, value] }.join("\n")
      script = exports.empty? ? command : [exports, command].compact.join("\n")
      h.write(script)
    end
    if input.empty?
      in_descriptor = {}
    else
      in_file = Tempfile.new(prefix)
      Pathname(in_file.path).open("w") do |h|
        h.write(input.to_yaml)
      end
      in_descriptor = {:in => [in_file.path, "r"]}
    end
    bash = "bash %s" % [script_file.path]
    descriptors = {:out => [out_file.path, "w"], :err => [:child, :out]}.merge(in_descriptor)
    Process.wait(spawn(bash, descriptors))
    if ($?.exitstatus != 0) 
      puts YAML.load(<<-EOM) % [script_file.read, out_file.read, $?.exitstatus]
      |-
       
        Execution: 
        ---
        %s
        ---
        Failure:
        ---
        %s
        ---
        Exit Status: %s
      EOM
      exit
    end
    return out_file.read
  end
  module_function :current_excercise, :require_all_tasks, :execute
end
