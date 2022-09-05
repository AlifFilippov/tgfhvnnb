class EventsController < ApplicationController
skip_before_filter :verify_authenticity_token, :only => [:create]

  def index
    if @auth
     @events = Event.where( :user_id => @auth.id )
    else
      redirect_to root_path
    end
  end

  def new
  end

  def create
    @url = params[:u]
    @event = Event.new
    if @auth
      puts "this is an auth user => #{@auth}"
      @event.user_id = @auth.id
      # begin
        @event.parse(@url)
      # rescue
        @event.link = @url
        @event.save
      # end
      msg = "Event saved!"
    else
      puts "not logged index" # heroku logs debug
      msg = "Please login or register an account with Gigmarklet to save events"
    end
    #render :nothing => true
    # render :json => { :result => msg }
    redirect_to events_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event= Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.delete
    redirect_to events_path
  end
end


