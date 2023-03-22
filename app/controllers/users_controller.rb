class UsersController < ApplicationController

  def create 
    response = Cloudinary::Uploader.upload(params[:profile_picture], resource_type: :auto)
    cloudinary_url = response["secure_url"]
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      profile_picture: cloudinary_url,
    )
    if user.save
      render json: user.as_json
    else
      render json: {errors: user.errors.full_messages}, status: 422
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

  def update 
    id = params[:id]
    u = User.find_by(id: id)
    if current_user.id == u.id 
      u.name = params[:name] || u.name 
      u.profile_picture = params[:profile_picture] || u.profile_picture
      u.email = params[:email] || u.email 
      if u.save 
        render json: u.as_json
      else 
        render json: {
          error: "did not save"
        }
      end 

    end 
  end 
end
