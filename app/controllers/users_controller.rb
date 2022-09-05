class UsersController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @users = User.all
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = @auth
    end
  end

  def events
    @events = @auth.events
  end

  def edit
    if params[:id]
      @profile = User.find(params[:id])
    else
      @profile = @auth
    end
  end

  def update
    if @auth.update_attributes(params[:user])
      redirect_to profile_path
    else
      render :edit
    end
  end

  private
  def ensure_logged_in
    redirect_to root_path if @auth.nil?
  end
end
