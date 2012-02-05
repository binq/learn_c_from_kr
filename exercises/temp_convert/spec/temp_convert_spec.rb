require 'yaml'
require Pathname(__FILE__).dirname + '../../../share/utils'
require Pathname(__FILE__).dirname + '../share/temp_convert'
describe "Temparature converter" do
  script = Pathname(__FILE__).dirname + '../share/temp_convert.rb'
  it "should correctly convert absolute zero from Fahrenheit to Celsius" do
    TempConvert.calc(-459.67).should be_within(1.0e-05).of(-273.15)
  end
  it "should display the table in reverse as per excercise 1-5" do
    command = "ruby %s" % [script]
    input = {:name => "reverse_table", :arguments => [300, 0, 20]}
    result = Utils.execute(command, :input => input).split("\n")
    result[1].should match /300.00 =>/
    result[-1].should match /0.00 =>/
  end
end
