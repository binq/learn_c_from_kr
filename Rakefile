%w'pathname tempfile rubygems spec/rake/spectask'.each do |i|
  require i
end

def execute(command, env={})
  tempfile = Tempfile.new(Pathname(__FILE__).basename.to_s.gsub(/\.[^\.]*/, ''))

  Pathname(tempfile.path).open("w") do |fh|
    env.each do |key, value|
      fh << "%s=%s\n" % [key, value]
    end
    fh << "%s\n" % [command]
  end
  
  command = "bash %s" % [tempfile.path]
  result = system(command)
  raise "system call failed" unless result && $? == 0 && yield
  
  tempfile.delete
rescue
  puts "\nWhen executing: %s\nGot: %p\n\n" % [command, {result: result, exit_code: $?.exitstatus, test: yield}]
  raise $!
end

namespace :temp_convert do
  root = Pathname(__FILE__).dirname + "exercises/temp_convert"

  lib_dir = root + "lib"
  lib_name = "temp_convert"
  lib_src_path = root + "src/temp_convert.c"
  lib_bin_path = lib_dir + "lib%s.dylib" % [lib_name]
  env = {DYLD_LIBRARY_PATH: lib_dir}

  main_src_path = root + "src/runner.c"
  main_bin_path = root + "bin/temp_convert"

  file main_bin_path => [lib_bin_path, main_src_path] do
    execute("gcc -O2 -o %s -l%s %s" % [main_bin_path, lib_name, main_src_path], env) do
      main_bin_path.exist?
    end
  end
  
  file lib_bin_path => lib_src_path do
    execute("gcc -shared -O2 -o %s -c %s" % [lib_bin_path, lib_src_path]) do
      lib_bin_path.exist?
    end
  end
  
  task :clean do
    system("rm -rf %s %s" % [root + 'lib', root + 'bin'])
  end
  
  task :create_directories => :clean do
    [main_bin_path, lib_bin_path].each { |file| file.dirname.mkpath unless file.dirname.exist? }
  end

  Spec::Rake::SpecTask.new(:spec => [:create_directories, lib_bin_path, main_bin_path]) do |t|
    env.each do |key, value|
      ENV[key.to_s] = value.to_s
    end
    
    t.spec_files = FileList[(root + 'spec/**/*.rb').to_s]
  end
end

desc "runs spec on the src for the current excercise"
task :spec => 'temp_convert:spec'

task :default => :spec