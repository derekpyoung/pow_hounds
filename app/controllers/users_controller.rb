class UsersController < ApplicationController

  def create 
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save!
      render json: {message: "User successfully created."}
    else  
      # render json: {errors: user.error.full_messages }, status :bad_request
      render json: "nope"
    end 
  end 

  def index 
    render json: User.all
  end 

  def show 
    id = params[:id]
    render json: User.find_by(id: id)
  end 

  def posts 
    id = params[:id]
    u = User.find_by(id: id)
    render json: u.posts.as_json
  end 
end
