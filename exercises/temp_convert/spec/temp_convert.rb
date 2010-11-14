require 'ffi'

module TempConvert
  extend FFI::Library

  lib = Pathname(__FILE__).dirname + "../bin/temp_convert"
  ffi_lib lib.to_s

  attach_function :temp_convert, [:float], :float
end

describe "Temparature converter" do
  it "should correctly convert absolute zero from Fahrenheit to Celsius" do
    TempConvert.temp_convert(-459.67).should == -273.15
  end
end
