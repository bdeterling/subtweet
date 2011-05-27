Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['SUBTWEET_CONSUMER_KEY'], ENV['SUBTWEET_CONSUMER_SECRET']
end
