class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])
    session[:user_id] = user.id
    # session[:user] = user
    redirect_to "/profile"
  end
end
