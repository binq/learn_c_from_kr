%w'ffi yaml pathname'.each { |i| require i }
module TempConvert
  extend FFI::Library
  name         = "temp_convert"
  root         = Pathname(__FILE__).dirname + ".."
  lib_bin_path = root + "lib/lib%s.dylib" % [name]
  ffi_lib lib_bin_path
  attach_function :temp_convert, [:float], :float
  alias_method :calc, :temp_convert
  module_function :calc
  attach_function :temp_convert_table, [:float, :float, :float], :void
  alias_method :table, :temp_convert_table
  attach_function :temp_convert_table_rev, [:float, :float, :float], :void
  alias_method :reverse_table, :temp_convert_table_rev
end
if __FILE__ == $0
  extend TempConvert
  rpc = YAML::load($stdin.read)
  send(rpc[:name], *rpc[:arguments])
end
