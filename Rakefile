%w'pathname rubygems spec/rake/spectask'.each do |i|
  require i
end

namespace :temp_convert do
  root = Pathname(__FILE__).dirname + "exercises/temp_convert"
  bin = root + "bin/temp_convert"
  lib = root + "lib/temp_convert.o"
  src = root + "src/temp_convert.c"
  run = root + "src/runner.c"
  debug_gcc_result = lambda { |r| puts "gcc: %s" % [r] }

  file bin => [lib, run] do
    raise unless system("gcc -O2 -o %s %s %s" % [bin, lib, run]).tap(&debug_gcc_result)
  end
  
  file lib => src do
    raise unless system("gcc -O2 -o %s -c %s" % [lib, src]).tap(&debug_gcc_result)
  end
  
  task :clean do
    system("rm -rf %s %s" % [root + 'lib', root + 'bin'])
  end
  
  task :create_directories => :clean do
    [bin, lib].each { |file| file.dirname.mkpath unless file.dirname.exist? }
  end

  Spec::Rake::SpecTask.new(:spec => [:create_directories, bin]) do |t|
    t.spec_files = FileList[(root + 'spec/**/*.rb').to_s]
  end
end

desc "runs spec on the src for the current excercise"
task :spec => 'temp_convert:spec'

task :default => :spec