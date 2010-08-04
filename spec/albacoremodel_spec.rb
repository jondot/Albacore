require File.join(File.dirname(__FILE__), 'support', 'spec_helper')
require 'albacore/albacoremodel'

class ModelTest
  include AlbacoreModel
  attr_accessor :foo, :bar
  attr_hash :a_hash
  attr_array :a_array
end

describe "when updating object attributes with a valid set of hash keys" do
  before :each do
    @model = ModelTest.new
    @model << {:foo => "test", :bar => "whatever"}
  end

  it "should set the attributes correctly" do
    @model.foo.should == "test"
    @model.bar.should == "whatever"
  end
end

describe "when updating an object attributes with an invalid hash key" do
  before :each do
    @model = ModelTest.new
    str = StringIO.new
    @model.log_device = str
    @model << {:something => "broken"}
    @log = str.string
  end

  it "should warn about the attribute not being found" do
    @log.should include("something is not a settable attribute on ModelTest")
  end
end