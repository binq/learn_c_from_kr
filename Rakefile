%w'pathname ./lib/utils'.each { |libname| require libname }
ROOT = Pathname(__FILE__).dirname.realpath
require_all_tasks
current_excercise = 'temp_convert'
desc "clean and build the current excercise"
task :clean_build => '%s:clean_build' % [current_excercise]
desc "clean the current excercise"
task :clean => '%s:clean' % [current_excercise]
desc "build the current excercise"
task :build => '%s:build' % [current_excercise]
task :default => :build
