

class LoggedMovie < ApplicationRecord
  # Validations can be added if necessary
  validates :tmdb_id, presence: true, uniqueness: true
  validates :title, presence: true

  # If you want to store genre IDs in the array, ensure correct serialization
  serialize :genre_ids, Array
end
