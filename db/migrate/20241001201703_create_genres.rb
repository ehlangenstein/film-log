class CreateGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :genres do |t|
      t.integer id 
      t.string name
      t.timestamps
    end
  end
end
