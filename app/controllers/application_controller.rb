class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def oauth_header(uri)
    parsed_uri = URI.parse(uri)
    uri = "#{parsed_uri.scheme}://#{parsed_uri.host}#{parsed_uri.path}"
    parameters = Rack::Utils.parse_query(parsed_uri.query)
    nonce = OAuth::Helper.generate_key
    timestamp = OAuth::Helper.generate_timestamp
    request = OAuth::RequestProxy.proxy "method" => 'GET', "uri" => uri, 
        "parameters" => { "oauth_consumer_key" => Consumer_key, "oauth_timestamp" => timestamp, "oauth_token" => Token, 
                          "oauth_version" => "1.0", "oauth_nonce" => nonce, "oauth_signature_method" => 'HMAC-SHA1' }.merge(parameters)
    request.sign!(:consumer_secret => Consumer_secret, :token_secret => Token_secret)
    request.oauth_header
  end


private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
