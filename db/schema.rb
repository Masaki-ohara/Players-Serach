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

ActiveRecord::Schema.define(version: 2023_10_20_160653) do

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "prediction_id", null: false
    t.integer "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_comments_on_match_id"
    t.index ["prediction_id"], name: "index_comments_on_prediction_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "season"
  end

  create_table "games", force: :cascade do |t|
    t.integer "league", null: false
    t.integer "season"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "matches", force: :cascade do |t|
    t.string "home_team_name"
    t.string "away_team_name"
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date"
    t.integer "round"
    t.string "league"
    t.index ["user_id"], name: "index_matches_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "player_name"
    t.string "team"
    t.integer "season"
    t.integer "age"
    t.integer "league", null: false
    t.string "image_url", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "predictions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "match_id"
    t.string "predicted_winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "home_score"
    t.integer "away_score"
    t.string "predicted_loser"
    t.string "comment"
    t.string "draw"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "matches"
  add_foreign_key "comments", "predictions"
  add_foreign_key "comments", "users"
  add_foreign_key "matches", "users"
  add_foreign_key "players", "users"
end
