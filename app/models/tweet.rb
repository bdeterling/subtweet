class Tweet
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

  attr_accessor :id, :account, :text, :created_at
    
  def initialize(account, attributes = {})  
    self.account = account
    [:id, :text, :created_at].each do |name|  
      if name == :created_at
        self.created_at = Time.parse(attributes.created_at)
      else
        send("#{name}=", attributes.send(name))  
      end
    end  
  end  
    
  def persisted?  
    false  
  end  

  def to_s
    "User: #{account.screen_name}, Text: #{text}, Time: #{created_at}"
  end

end
