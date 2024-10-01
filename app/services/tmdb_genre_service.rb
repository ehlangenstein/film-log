require 'uri'
require 'net/http'
require 'json'

class TmdbGenreService
  TMDB_API_URL = "https://api.themoviedb.org/3/genre/movie/list?language=en"
  TMDB_API_KEY = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzRlOGFkYWU5ZWM1MzZkYzUzYzNjMzI1ZTc4MjgwMSIsIm5iZiI6MTcyNzgwNzgyMS41OTMzNjEsInN1YiI6IjY2ZjQ3Y2ExZjViNDk3ODY0MzIzMjUwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IAJLJU5n1UaYm1ZKhwQRhoOvcm4KNR4z7HD3hZfZzuE"

  def self.fetch_genres
    url = URI(TMDB_API_URL)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = TMDB_API_KEY

    response = http.request(request)
    genres_data = JSON.parse(response.read_body)

    if genres_data["genres"]
      genres_data["genres"].each do |genre|
        Genre.find_or_create_by(genre_id: genre["id"], name: genre["name"])
      end
    else
      puts "Error fetching genres"
    end
  end
end

