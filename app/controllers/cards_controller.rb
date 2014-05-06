class CardsController < ApplicationController
  def index
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    render json: @user.card
  end

  def new
  end
end
