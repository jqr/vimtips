require 'twitter'
class Tip
  include DataMapper::Resource

  property :id, Serial
  property :body, String, :length => (1..140), :nullable => false
  property :tweeted_at, DateTime

  def self.tweeted
    all(:tweeted_at.not => nil)
  end

  def self.untweeted
    all(:tweeted_at => nil)
  end

  def self.random_tip
    tip = untweeted[Kernel.rand(untweeted.size)]
  end

  def self.tweet
    tip = random_tip
    twitter_user, twitter_pass = get_twitter_info
    Twitter::Base.new(twitter_user, twitter_pass).post(tip.body)
    tip.tweeted_at = Time.now
    tip.save
  end

  protected

  def self.get_twitter_info
    config = YAML.load_file("#{Merb::Config.merb_root}/config/twitter.yml")
    [config['username'], config['password']]
  end
end
