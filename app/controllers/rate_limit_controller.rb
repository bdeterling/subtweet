class RateLimitController < ApplicationController
  def index
    @rate_limit = GrackleClient.account.rate_limit_status.json?
    path = "http://api.twitter.com/1/account/rate_limit_status.json"
    @rate_limit_curl = Curl::Easy.perform(path) { |curl|
      curl.headers["Authorization"] = oauth_header(path)
    }.body_str
  end
end
