# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150123174634) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city"
    t.string   "state"
    t.string   "address1"
    t.string   "address2"
    t.string   "zip"
    t.string   "hours"
    t.string   "description"
  end

  add_index "businesses", ["user_id"], name: "index_businesses_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.string   "message"
    t.datetime "sent_on"
    t.integer  "phone_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["phone_list_id"], name: "index_messages_on_phone_list_id", using: :btree

  create_table "phone_lists", force: true do |t|
    t.integer  "business_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_lists", ["business_id"], name: "index_phone_lists_on_business_id", using: :btree

  create_table "phone_numbers", force: true do |t|
    t.string   "number"
    t.integer  "phone_list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "verification_code"
    t.boolean  "verified",          default: false, null: false
    t.boolean  "active",            default: true,  null: false
    t.string   "stop_code"
    t.string   "start_code"
  end

  add_index "phone_numbers", ["phone_list_id"], name: "index_phone_numbers_on_phone_list_id", using: :btree

  create_table "suggesteds", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "status",                 default: 0
    t.string   "stripe_customer_id"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
