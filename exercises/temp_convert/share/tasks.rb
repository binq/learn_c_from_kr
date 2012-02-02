%w'pathname fileutils rspec/core/rake_task'.each { |libname| require libname }
namespace :temp_convert do
  name         = "temp_convert"
  root         = ROOT + "exercises/%s" % [name]
  lib_src_path = root + "src/lib%s.c" % [name]
  lib_bin_path = root + "lib/lib%s.dylib" % [name]
  lib_dir      = root + "lib"
  src_path     = root + "src/%s.c" % [name]
  bin_path     = root + "bin/%s" % [name]
  bin_dir      = root + "bin"
  include_path = root + "include"
  env          = {DYLD_LIBRARY_PATH: lib_dir, LIBRARY_PATH: lib_dir, CPATH: include_path}
  file bin_path => [lib_bin_path, src_path] do
    verify_path = lambda { bin_path.exist? }
    execute("gcc -O3 -l%s -o %s %s" % [name, bin_path, src_path], env, &verify_path)
  end
  file lib_bin_path => lib_src_path do
    execute("gcc -O3 -shared -o %s %s" % [lib_bin_path, lib_src_path])
  end
  RSpec::Core::RakeTask.new(:spec => lib_bin_path) do |spec|
    spec.pattern = "%s/%s" % [root, 'spec/**/*_spec.rb']
    spec.rspec_opts = ['--backtrace']
  end
  task :setup_directories => :clean do
    FileUtils.mkpath([bin_dir, lib_dir])
  end
  desc 'clean'
  task :clean do
    FileUtils.rm_rf([bin_dir, lib_dir])
  end
  desc 'build'
  task :build => [:setup_directories, bin_path, :spec]
  desc 'clean_build'
  task :clean_build => [:clean, :build]
end
