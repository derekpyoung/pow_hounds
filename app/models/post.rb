class Post < ApplicationRecord
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'


  
  def getLatLong
    url = URI("https://ski-resort-forecast.p.rapidapi.com/snoqualmie/forecast?units=i&el=top")
  
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Host"] = 'ski-resort-forecast.p.rapidapi.com'
    request["X-RapidAPI-Key"] = '14d22ac7a2mshae0f2dd3e38db5bp1374f2jsna6dfac09cddc'

    response = http.request(request)
    weather =  JSON.parse(response.read_body)
    lat = weather["basicInfo"]["lat"]
    long = weather["basicInfo"]["lon"]

  end 
  

end
