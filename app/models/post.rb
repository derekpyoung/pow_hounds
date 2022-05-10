class Post < ApplicationRecord
  require 'uri'
  require 'net/http'
  require 'openssl'
  require 'json'
  belongs_to :user 
  validates :title, presence: true
  validates :description, presence: true 
  validates :resort, presence: true



  
  def getLatLong
    url = URI("https://ski-resort-forecast.p.rapidapi.com/snoqualmie/forecast?units=i&el=top")
  
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
  
    response = http.request(request)
    weather =  JSON.parse(response.read_body)
    lat = weather["basicInfo"]["lat"]
    long = weather["basicInfo"]["lon"]

  end 
  

end
