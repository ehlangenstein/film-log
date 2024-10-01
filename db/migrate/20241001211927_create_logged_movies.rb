class CreateLoggedMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :logged_movies do |t|
      t.integer :tmdb_id, null: false  # Corresponds to the TMDB movie ID
      t.string :title, null: false     # The movie's title
      t.text :overview                 # Movie description/overview
      t.string :poster_path            # URL path for the poster
      t.string :release_date           # Release date
      t.float :rating                  # The rating you've given the movie
      t.integer :budget             
      t.integer :revenue
      t.string :imdb_id
      t.timestamps
    end
    # Add an index for the TMDB movie ID for faster lookups
    add_index :logged_movies, :tmdb_id, unique: true
  end
end
