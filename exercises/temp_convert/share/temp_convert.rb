require 'ffi'
require 'pathname'
module TempConvert
  extend FFI::Library
  name         = "temp_convert"
  root         = Pathname(__FILE__).dirname + ".."
  lib_bin_path = root + "lib/lib%s.dylib" % [name]
  ffi_lib lib_bin_path
  attach_function :temp_convert, [:float], :float
  attach_function :temp_convert_range, [:float, :float, :float], :void
  attach_function :temp_convert_table, [:float, :float, :float], :void
end
if __FILE__ == $0
  extend TempConvert
  start_temp = -459.67
  end_temp = 10000.0
  step = 20.0
  temp_convert_table(start_temp, end_temp, step);
end
