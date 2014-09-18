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

ActiveRecord::Schema.define(version: 20140918201033) do

  create_table "admin_pages", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "coupons", force: true do |t|
    t.integer  "login_id"
    t.integer  "type_c"
    t.string   "name"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "amount"
  end

  create_table "logins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "identification"
    t.string   "phone"
    t.string   "mobile"
    t.string   "number_account"
    t.string   "account_type"
    t.string   "status"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.integer  "level_id",               default: 1
    t.integer  "sponsor_id"
    t.string   "paypal"
    t.string   "skype"
    t.string   "avatar"
    t.integer  "room_id"
    t.string   "address"
    t.boolean  "activated",              default: false
    t.integer  "position"
    t.boolean  "mlm_started",            default: false
  end

  add_index "logins", ["email"], name: "index_logins_on_email", unique: true, using: :btree
  add_index "logins", ["identification"], name: "index_logins_on_identification", unique: true, using: :btree
  add_index "logins", ["reset_password_token"], name: "index_logins_on_reset_password_token", unique: true, using: :btree
  add_index "logins", ["username"], name: "index_logins_on_username", unique: true, using: :btree

  create_table "logins_payments", force: true do |t|
    t.integer "payment_id"
    t.integer "login_id"
  end

  create_table "managers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.text     "message"
    t.integer  "uSent_ID"
    t.integer  "uReceived_ID"
    t.integer  "login_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.boolean  "read",       default: false
    t.string   "message"
    t.string   "link"
    t.integer  "login_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_id",   default: 1
    t.string   "receipt"
    t.integer  "login_id",                   null: false
    t.text     "comment"
    t.integer  "type_p"
    t.integer  "coupon_id"
    t.boolean  "status",     default: false
    t.string   "gateway"
  end

  create_table "rooms", force: true do |t|
    t.integer  "level_id",    default: 1
    t.boolean  "status",      default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "left_nextp",  default: 4
    t.integer  "right_nextp", default: 6
  end

end
