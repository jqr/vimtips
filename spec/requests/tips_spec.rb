require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a Tip exists" do
  Tip.all.destroy!
  request(resource(:tips), :method => "POST",
          :params => { :tip => { :body => 'A great tip.' }})
end

describe "resource(:tips)" do
  describe "GET" do

    before(:each) do
      login
      @response = request(resource(:tips))
    end

    it "responds successfully" do
      @response.should be_successful
    end

    it "has a list of tips" do
      @response.should have_xpath("//ul")
    end
  end

  describe "GET", :given => "a Tip exists" do
    before(:each) do
      @response = request(resource(:tips))
    end

    it "has a list of tips" do
      @response.should have_xpath("//ul/li")
    end
  end
end
