class WelcomeController < ApplicationController
  def lookup
    @account = Account.from_screen_name(params[:screen_name])
  end

  def index
    @names = params[:names].nil? ? [] : params[:names].split('/')
  end
end
