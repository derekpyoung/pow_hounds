class ForecastsController < ApplicationController
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'

  def threeDay
    url = URI("https://ski-resort-forecast.p.rapidapi.com/#{params[:resort]}/forecast?units=i&el=top")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = api_tokens["forecast_api_host_url"] 
    request["X-RapidAPI-Key"] = api_tokens["forecast_api_token"]
    response = http.request(request)
    three_day = JSON.parse(response.read_body)
    render json: three_day["summary3Day"]
    # p three_day["summary3Day"]
    
  end 

  def snow_inches
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
    render json: weather 
    puts weather

    lat_long_arr << weather["basicInfo"]["lat"]
    lat_long_arr << weather["basicInfo"]["lon"]
    p lat_long_arr

  end 
  private 

  def api_tokens
    @api_tokens ||= YAML::load_file('tokens.yml')
  end 
end
