class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if !user.card
      @card = Card.new
      user.card = @card
    end
    redirect_to user
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end