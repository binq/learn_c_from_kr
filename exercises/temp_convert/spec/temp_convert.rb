require 'ffi'
require 'pathname'

module TempConvert
  extend FFI::Library

  lib_path = Pathname('/Users/vanson/Projects/learn_c_from_kr/exercises/temp_convert/lib/libtemp_convert.dylib')
  raise "lib not found" unless lib_path.exist?
  ffi_lib 'temp_convert'

  attach_function :temp_convert, [:float], :float
end