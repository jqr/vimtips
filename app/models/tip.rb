class Tip
  include DataMapper::Resource

  property :id, Serial
  property :body, String, :length => (1..140), :nullable => false
  property :tweeted, Boolean

end
