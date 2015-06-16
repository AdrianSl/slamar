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

ActiveRecord::Schema.define(version: 20150616154901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brand_shops", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brand_shops", ["name"], name: "index_brand_shops_on_name", using: :btree

  create_table "drivers", force: :cascade do |t|
    t.text     "name"
    t.text     "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drivers", ["name"], name: "index_drivers_on_name", using: :btree
  add_index "drivers", ["surname"], name: "index_drivers_on_surname", using: :btree

  create_table "external_shops", force: :cascade do |t|
    t.text     "name"
    t.boolean  "daily_payments"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "external_shops", ["name"], name: "index_external_shops_on_name", using: :btree

  create_table "general_expenses", force: :cascade do |t|
    t.text     "name"
    t.float    "value"
    t.date     "date"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "general_expenses", ["date"], name: "index_general_expenses_on_date", using: :btree
  add_index "general_expenses", ["name"], name: "index_general_expenses_on_name", using: :btree
  add_index "general_expenses", ["user_id"], name: "index_general_expenses_on_user_id", using: :btree

  create_table "incomes", force: :cascade do |t|
    t.float    "value"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "incomes", ["date"], name: "index_incomes_on_date", using: :btree

  create_table "truck_routes", force: :cascade do |t|
    t.text     "name"
    t.text     "weekdays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "truck_routes", ["name"], name: "index_truck_routes_on_name", using: :btree
  add_index "truck_routes", ["weekdays"], name: "index_truck_routes_on_weekdays", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "general_expenses", "users"
end
