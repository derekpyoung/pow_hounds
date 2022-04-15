class PostsController < ApplicationController

  def index 
    render json: Post.all
  end 

  def show 
    id = params[:id]
    post = Post.find_by(id: id)
    render json: post
  end 

  def create 
    post = Post.new(
      user_id: params[:user_id],
      title: params[:title],
      runs_taken: params[:runs_taken],
      snow: params[:snow],
      weather: params[:weather],
      description: params[:description],
      resort: params[:resort],
      photo: params[:photo]
    )
    post.save
    render json: post 
  end

  def destroy 
    id = params[:id]
    post = Post.find_by(id: id)
    post.delete
    render json: post
  end 


end
