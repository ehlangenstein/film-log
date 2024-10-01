require 'uri'
require 'net/http'

url = URI("https://api.themoviedb.org/3/genre/movie/list?language=en")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request["accept"] = 'application/json'
request["Authorization"] = 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzRlOGFkYWU5ZWM1MzZkYzUzYzNjMzI1ZTc4MjgwMSIsIm5iZiI6MTcyNzgwNzgyMS41OTMzNjEsInN1YiI6IjY2ZjQ3Y2ExZjViNDk3ODY0MzIzMjUwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IAJLJU5n1UaYm1ZKhwQRhoOvcm4KNR4z7HD3hZfZzuE'

response = http.request(request)
puts response.read_body