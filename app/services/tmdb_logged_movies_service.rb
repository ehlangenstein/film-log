require 'uri'
require 'net/http'
require 'json'

class TmdbLoggedMoviesService
  TMDB_API_URL = "https://api.themoviedb.org/3/account/21538508/rated/movies?language=en-US&page=1&sort_by=created_at.asc"
  TMDB_API_KEY = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzRlOGFkYWU5ZWM1MzZkYzUzYzNjMzI1ZTc4MjgwMSIsIm5iZiI6MTcyNzgwNzgyMS41OTMzNjEsInN1YiI6IjY2ZjQ3Y2ExZjViNDk3ODY0MzIzMjUwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.IAJLJU5n1UaYm1ZKhwQRhoOvcm4KNR4z7HD3hZfZzuE"  # Replace with your actual TMDB API key

  def self.fetch_and_store_logged_movies
    url = URI(TMDB_API_URL)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = TMDB_API_KEY

    response = http.request(request)
    movies_data = JSON.parse(response.body)

    if movies_data["results"]
      movies_data["results"].each do |movie_data|
        # Create or update a logged movie record
        LoggedMovie.find_or_create_by(tmdb_id: movie_data["id"]) do |movie|
          movie.title = movie_data["title"]
          movie.overview = movie_data["overview"]
          movie.poster_path = movie_data["poster_path"]
          movie.release_date = movie_data["release_date"]
          movie.rating = movie_data["rating"]
          movie.genre_ids = movie_data["genre_ids"]

        end
      end
    else
      puts "Error fetching movies from TMDB"
    end
  end

  # Fetches detailed movie data and updates the record
  def self.fetch_movie_details(tmdb_id)
    url = URI("#{TMDB_API_URL_MOVIE_DETAILS}#{tmdb_id}?language=en-US")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = TMDB_API_KEY

    response = http.request(request)
    movie_data = JSON.parse(response.read_body)

    if movie_data["id"]
      # Find or update the movie with detailed information
      logged_movie = LoggedMovie.find_or_create_by(tmdb_id: movie_data["id"]) do |movie|
        movie.title = movie_data["title"]
        movie.imdb_id = movie_data["imdb_id"]
        movie.budget = movie_data["budget"]
        movie.revenue = movie_data["revenue"]
        movie.release_date = movie_data["release_date"]
      end

      # Associate genres with the movie
      if movie_data["genres"]
        movie_data["genres"].each do |genre_data|
          genre = Genre.find_or_create_by(tmdb_id: genre_data["id"], name: genre_data["name"])
          logged_movie.genres << genre unless logged_movie.genres.include?(genre)
        end
      end

      logged_movie.save
    else
      puts "Error fetching movie details for TMDB ID: #{tmdb_id}"
    end
  end
end

