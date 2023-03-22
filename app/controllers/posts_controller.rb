class PostsController < ApplicationController

  def index 
    @posts = Post.all
    # render template: 'posts/index'
    render json: @posts 
  end 

  def users_posts
    user_id = params[:id]
    p "user id #{user_id}"
    @user = User.find(user_id)
    @posts = @user.posts
    # render template: 'posts/index'
    render json: @posts 

  end 

  def show 
    id = params[:id]
    @post = Post.find_by(id: id)
    render json: @post
  end 

  def current
    render json: current_user.id
  end 

  def create 
    # ----------------------Get snow in inches api call-------------------------------------
    url = URI("https://ski-resort-forecast.p.rapidapi.com/#{params[:resort]}/snowConditions?units=i")
    lat_long_arr = []
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = api_tokens["forecast_api_host_url"] 
    request["X-RapidAPI-Key"] = api_tokens["forecast_api_token"]

    response = http.request(request)
    weather =  JSON.parse(response.read_body)
    # render json: weather 
    puts weather["freshSnowfall"]
#-------------------------------threeday summery api call---------------------------------
    url = URI("https://ski-resort-forecast.p.rapidapi.com/#{params[:resort]}/forecast?units=i&el=top")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = api_tokens["forecast_api_host_url"] 
    request["X-RapidAPI-Key"] = api_tokens["forecast_api_token"]
    response = http.request(request)
    three_day = JSON.parse(response.read_body)
    # render json: three_day["summary3Day"]
    p three_day["summary3Day"]
    #--------------------------Cloudinary photo upload--------------------------------------------

    response = Cloudinary::Uploader.upload(params[:photo], resource_type: :auto)
    cloudinary_url = response["secure_url"]
      
    @post = Post.new(
      user_id: current_user.id,
      title: params[:title],
      runs_taken: params[:runs_taken],
      snow: weather["freshSnowfall"],
      weather: three_day["summary3Day"],
      description: params[:description],
      resort: params[:resort],
      photo: cloudinary_url
    )
    if @post.save
      render json: @post
    else  
      render json: {error: post.errors.full_messages}, status: 422
    end 
   
  end

  def destroy 
    id = params[:id]
    @post = Post.find_by(id: id)
    @post.delete
    render json: post
  end 

  private 
    def api_tokens
      @api_tokens ||= YAML::load_file('tokens.yml')
    end 



end
