class Account
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

  def self.from_screen_name(screen_name)
    r = GrackleClient.users.show.json :screen_name => screen_name
    Account.new({ id: r.id, screen_name: screen_name, status: r.status.text, 
                friends: r.friends_count, followers: r.followers_count, profile_image_url: r.profile_image_url })
  rescue Grackle::TwitterError => e
    return nil if e.status == 404
    raise TwitterOverCapacity if e.response_body =~ /over capacity/i
    raise e
  end

  def self.from_id(id)
    r = GrackleClient.users.show.json :id=>id
    Account.new({ id: r.id, screen_name: screen_name, status: r.status.text, 
                friends: r.friends_count, followers: r.followers_count, profile_image_url: r.profile_image_url })
  rescue Grackle::TwitterError => e
    return nil if e.status == 404
    raise TwitterOverCapacity if e.response_body =~ /over capacity/i
    raise e
  end

  attr_accessor :id, :screen_name, :status, :friends, :followers, :profile_path, :profile_image_url
    
  def initialize(attributes = {})  
    attributes.each do |name, value|  
      send("#{name}=", value)  
    end  
  end  
    
  def persisted? c
    false  
  end  

  def to_s
    "Screen Name: #{screen_name}, Friends: #{friends}, Followers: #{followers}, Status: #{status}"
  end

  def last_n_tweets(n=5)
    #http://api.twitter.com/1/statuses/user_timeline/#{tweep[:screen_name]}.json?count=#{@count}"
    results = GrackleClient.statuses.user_timeline.json :id => id, :count => n
    results.map do |r|
      Tweet.new(self, r)
    end
  end
end
