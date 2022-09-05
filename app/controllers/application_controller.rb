class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  private
  def authenticate
    @auth = User.where(:id => session[:user_id]).first
  end
end
