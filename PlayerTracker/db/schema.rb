# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_30_001619) do

  create_table "games", force: :cascade do |t|
    t.date "date"
    t.string "opponent"
    t.integer "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_games_on_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "number"
    t.boolean "coach"
    t.integer "user_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["team_id"], name: "index_players_on_team_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trackers", force: :cascade do |t|
    t.float "x1"
    t.float "y1"
    t.float "x2"
    t.float "y2"
    t.boolean "complete"
    t.integer "player_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_trackers_on_game_id"
    t.index ["player_id"], name: "index_trackers_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "games", "teams"
  add_foreign_key "players", "teams"
  add_foreign_key "players", "users"
  add_foreign_key "trackers", "games"
  add_foreign_key "trackers", "players"
end
