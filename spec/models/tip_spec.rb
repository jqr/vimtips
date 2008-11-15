require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Tip do

  before(:each) do
    @tip = Tip.new
  end

  it "should require body not be nil" do
    @tip.body = nil
    @tip.should_not be_valid
  end

  it "should require body be less than 140 characters" do
    @tip.body = 'less than 140, more than 1'
    @tip.should be_valid
    141.times { |x| @tip.body += 'x' }
    @tip.should_not be_valid
  end
end
