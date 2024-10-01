
class GenresController < ApplicationController
  def index
    TmdbGenreService.fetch_genres
    @genres = Genre.all
  end
end
