require Pathname(__FILE__).dirname + 'temp_convert'

describe "Temparature converter" do
  it "should correctly convert absolute zero from Fahrenheit to Celsius" do
    TempConvert.temp_convert(-459.67).should == -273.15
  end
end
