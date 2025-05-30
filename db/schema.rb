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

ActiveRecord::Schema[7.1].define(version: 2025_05_30_003828) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "exchanges", force: :cascade do |t|
    t.string "status", default: "Pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "seen_status", default: true
    t.bigint "meal_offered_id"
    t.bigint "meal_requested_id"
    t.bigint "your_meal_id", null: false
    t.boolean "accepted", default: false
    t.boolean "seen", default: false
    t.bigint "meal_id", null: false
    t.integer "offering_user_rating"
    t.integer "requesting_user_rating"
    t.text "offering_user_comment"
    t.text "requesting_user_comment"
    t.bigint "requesting_user_id"
    t.index ["meal_id"], name: "index_exchanges_on_meal_id"
    t.index ["meal_offered_id"], name: "index_exchanges_on_meal_offered_id"
    t.index ["meal_requested_id"], name: "index_exchanges_on_meal_requested_id"
    t.index ["requesting_user_id"], name: "index_exchanges_on_requesting_user_id"
    t.index ["your_meal_id"], name: "index_exchanges_on_your_meal_id"
  end

  create_table "meal_ratings", force: :cascade do |t|
    t.integer "value"
    t.bigint "meal_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_meal_ratings_on_meal_id"
    t.index ["user_id"], name: "index_meal_ratings_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "ingredients"
    t.string "category"
    t.string "cuisine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.float "latitude"
    t.float "longitude"
    t.string "address"
    t.date "posted_on"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "exchange_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_messages_on_exchange_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "exchanges", "meals"
  add_foreign_key "exchanges", "meals", column: "meal_offered_id"
  add_foreign_key "exchanges", "meals", column: "meal_requested_id"
  add_foreign_key "exchanges", "meals", column: "your_meal_id"
  add_foreign_key "meal_ratings", "meals"
  add_foreign_key "meal_ratings", "users"
  add_foreign_key "meals", "users"
  add_foreign_key "messages", "exchanges"
  add_foreign_key "messages", "users"
end
