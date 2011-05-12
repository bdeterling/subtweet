puts 'Initializing grackle'
Consumer_key = 'mozwIMkTbGRPpKtV59ZKhw'
Consumer_secret = ENV['OAUTH_CONSUMER_SECRET']
Token = '14241551-IkTZeWYm6pJfYOCSuGu7AEx0G70TE12q8s6MYT...'
Token_secret = ENV['OAUTH_TOKEN_SECRET']
GrackleClient = Grackle::Client.new(:auth=>{
    :type=>:oauth,
    :consumer_key=>Consumer_key,
    :consumer_secret=>Consumer_secret,
    :token=>Token,
    :token_secret=>Token_secret
  })
GrackleClient.api_hosts[:v1] = 'api.twitter.com/1'
GrackleClient.api = :v1

