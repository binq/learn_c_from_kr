require Pathname(__FILE__).dirname + '../share/temp_convert'

describe "Temparature converter" do
  it "should correctly convert absolute zero from Fahrenheit to Celsius" do
    TempConvert.temp_convert(-459.67).should be_within(1.0e-05).of(-273.15)
  end
end
