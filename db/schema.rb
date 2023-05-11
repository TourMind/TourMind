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

ActiveRecord::Schema.define(version: 2023_05_08_090406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "author"
    t.float "rating"
    t.string "location"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.json "images"
    t.bigint "user_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "favorable_type", null: false
    t.bigint "favorable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["favorable_type", "favorable_id"], name: "index_favorites_on_favorable"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.string "star_rating"
    t.string "address"
    t.string "latitude"
    t.string "longitude"
    t.text "intro"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "hotel_types"
    t.string "tel"
    t.string "equipment", default: [], array: true
    t.json "images"
    t.string "slug"
    t.index ["slug"], name: "index_hotels_on_slug", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "amount"
    t.datetime "pay_time"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.integer "user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "days"
    t.json "locations"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.integer "people", default: 1
    t.boolean "public", default: false
    t.json "images"
    t.string "slug"
    t.index ["slug"], name: "index_plans_on_slug", unique: true
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.text "intro"
    t.string "address"
    t.string "lat"
    t.string "long"
    t.string "image"
    t.string "email"
    t.string "tel"
    t.string "website"
    t.string "restaurant_type"
    t.string "cuisine_types", default: [], array: true
    t.float "price"
    t.string "atmostphere", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.json "images"
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.string "address"
    t.string "latitude"
    t.string "longitude"
    t.float "stay_duration"
    t.text "intro"
    t.string "pet_freindly"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "site_types", default: [], array: true
    t.string "tel"
    t.string "image"
    t.string "parking"
    t.json "images"
    t.string "slug"
    t.index ["slug"], name: "index_sites_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "tel"
    t.string "city"
    t.string "location"
    t.string "address"
    t.string "avatar_url"
    t.string "provider"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "diamond_grade", default: "一般會員"
    t.string "amount"
    t.integer "role", default: 1
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end


  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "users"
  add_foreign_key "orders", "users"
  add_foreign_key "plans", "users"
  add_foreign_key "orders", "users"
end
