require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Tip do

  before(:each) do
    3.times { Tip.gen }
    3.times { Tip.gen(:tweeted_at => Time.now) }
    
    @twitter_connection = mock(Twitter::Base, :post => true)
    Tip.stub!(:twitter_connection).and_return(@twitter_connection)
  end

  it "should have a non-empty collection of tips" do
    Tip.all.should_not be_empty
  end

  it "should return untweeted tips on :untweeted" do
    Tip.untweeted.each do |t|
      t.tweeted_at.should == nil
    end
  end

  it "should return tweeted tips on :tweeted" do
    Tip.tweeted.each do |t|
      t.tweeted_at.should_not == nil
    end
  end

  it "should return a random untweeted tip on :random_tip" do
    t = Tip.random_tip
    t.class.should == Tip
    t.tweeted_at.should == nil
  end

  it "should be tweeted on :tweet" do
    @twitter_connection.should_receive(:post).and_return(true)
    Tip.tweet
  end
  
  it "should return an array of 2 strings on :get_twitter_info" do
    result = Tip.get_twitter_info
    result.class.should == Array
    result[0].class.should == String
  end
end

describe Tip, "instance" do

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
