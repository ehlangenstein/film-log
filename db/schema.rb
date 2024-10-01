# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_10_01_211927) do
  create_table "genres", force: :cascade do |t|
    t.integer "genre_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logged_movies", force: :cascade do |t|
    t.integer "tmdb_id", null: false
    t.string "title", null: false
    # want to delete overview for now??
    t.text "overview"
    t.string "poster_path"
    t.string "release_date"
    t.float "rating"
    t.integer "budget"
    t.integer "revenue"
    t.string "imdb_id"
    # need to delete these 
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false\
    #what does this do?
    t.index ["tmdb_id"], name: "index_logged_movies_on_tmdb_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "real_name"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
