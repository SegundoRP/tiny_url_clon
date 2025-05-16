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

ActiveRecord::Schema[7.1].define(version: 2025_05_16_005604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shortened_urls", force: :cascade do |t|
    t.string "full_url", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["full_url"], name: "index_shortened_urls_on_full_url"
    t.index ["token"], name: "index_shortened_urls_on_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "shortened_url_id", null: false
    t.string "ip_address", null: false
    t.string "user_agent"
    t.string "referer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shortened_url_id"], name: "index_visits_on_shortened_url_id"
  end

  add_foreign_key "visits", "shortened_urls"
end
