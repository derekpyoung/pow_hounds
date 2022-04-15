class UsersController < ApplicationController

  def create 
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    user.save
    pp user 
  end 

  def index 
    render json: User.all
  end 

  def show 
    id = params[:id]
    render json: User.find_by(id: id)
  end 
end
