class TweetsController < ApplicationController
  def index
    @account = Account.from_screen_name(params[:screen_name])
    if  @account.nil?
      raise "Account not found"
      return
    end
    @tweets = @account.last_n_tweets(5)
    render :layout => false, :content_type => 'text/html'
  end
end
