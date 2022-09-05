class RegisterController < ApplicationController

  def new
  end

  def create
    user = User.new(params[:register])
    if user.save
      redirect_to root_path
    else
      redirect_to register_path
    end
  end
end