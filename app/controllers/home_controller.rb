class HomeController < ApplicationController
  require 'open-uri'

  def index
  end

  def add_url
    @url = params[:u]
    @event = Event.new
    if @auth
      puts "this is an auth user => #{@auth}"
      @event.user_id = @auth.id
      begin
        @event.parse(@url)
      rescue
        @event.link = @url
        @event.save
      end
      msg = "Event saved!"
    else
      puts "not logged index" # heroku logs debug
      msg = "Please remember to login"
    end
    #render :nothing => true
    # render :json => { :result => msg }
    redirect_to events_path
  end

end
