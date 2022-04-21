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

  def forecast 
    arr = []
    response = HTTP.get("https://api.weather.gov/gridpoints/SEW/151,53/forecast")
    full_list = response.parse(:json)
    i = 0 
    while i < 10
      arr << full_list["properties"]["periods"][i]["detailedForecast"] + "*********************"
      i += 2
    end 
    pp arr 
    # render json: arr
  end 


end
