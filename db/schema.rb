# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171121090928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.bigint "hotel_id", null: false
    t.datetime "checked_out_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id", "hotel_id"], name: "index_check_ins_on_guest_id_and_hotel_id"
    t.index ["guest_id"], name: "index_check_ins_on_guest_id"
    t.index ["hotel_id"], name: "index_check_ins_on_hotel_id"
  end

  create_table "guests", force: :cascade do |t|
    t.json "profile", default: {}, null: false
    t.string "external_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_guests_on_external_id", unique: true
  end

  create_table "hotels", force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.string "external_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_hotels_on_external_id", unique: true
    t.index ["phone"], name: "index_hotels_on_phone", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "guest_id", null: false
    t.bigint "hotel_id", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_agent", default: false
    t.index ["guest_id", "hotel_id"], name: "index_messages_on_guest_id_and_hotel_id"
    t.index ["guest_id"], name: "index_messages_on_guest_id"
    t.index ["hotel_id"], name: "index_messages_on_hotel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "guest_id", null: false
    t.bigint "hotel_id", null: false
    t.text "content", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id", "hotel_id"], name: "index_notifications_on_guest_id_and_hotel_id"
    t.index ["guest_id"], name: "index_notifications_on_guest_id"
    t.index ["hotel_id"], name: "index_notifications_on_hotel_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.json "profile", default: {}, null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hotel_id"], name: "index_users_on_hotel_id"
  end

end
