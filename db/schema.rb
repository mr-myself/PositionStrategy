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

ActiveRecord::Schema.define(version: 20160217005033) do

  create_table "achievements", force: true do |t|
    t.integer  "company_number",   null: false
    t.integer  "publish_year",     null: false
    t.string   "publish_day"
    t.integer  "sale"
    t.integer  "operating_profit"
    t.integer  "ordinary_profit"
    t.integer  "net_income"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["company_number"], name: "index_achievements_on_company_number", using: :btree
  add_index "achievements", ["sale"], name: "index_achievements_on_sale", using: :btree

  create_table "companies", force: true do |t|
    t.string   "name",           null: false
    t.integer  "company_number", null: false
    t.integer  "market_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["company_number"], name: "index_companies_on_company_number", using: :btree

  create_table "details", force: true do |t|
    t.integer  "company_number", null: false
    t.integer  "industry_id",    null: false
    t.integer  "employee"
    t.string   "settling_day"
    t.integer  "age"
    t.integer  "annual_income"
    t.integer  "market_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "details", ["company_number"], name: "index_details_on_company_number", using: :btree
  add_index "details", ["market_value"], name: "index_details_on_market_value", using: :btree

  create_table "reset_tokens", force: true do |t|
    t.string   "token",      null: false
    t.string   "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_achievements", force: true do |t|
    t.string   "symbol",                            null: false
    t.string   "publish_day"
    t.integer  "sale",                    limit: 8
    t.integer  "operating_profit",        limit: 8
    t.integer  "net_income",              limit: 8
    t.integer  "period_type"
    t.integer  "operating_profit_margin"
    t.integer  "roa"
    t.integer  "roe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "us_achievements", ["sale"], name: "index_us_achievements_on_sale", using: :btree

  create_table "us_averages", force: true do |t|
    t.integer  "sector_id",                  null: false
    t.integer  "sale",             limit: 8
    t.integer  "operating_profit", limit: 8
    t.integer  "net_income",       limit: 8
    t.integer  "period_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_companies", force: true do |t|
    t.integer  "sector_id",    null: false
    t.integer  "industry_id",  null: false
    t.string   "name",         null: false
    t.string   "symbol",       null: false
    t.integer  "market_type"
    t.string   "market_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_competitors", force: true do |t|
    t.string   "my_symbol",    null: false
    t.string   "other_symbol", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_industries", force: true do |t|
    t.string "name", null: false
  end

  create_table "user_company_maps", force: true do |t|
    t.integer  "user_id",                              null: false
    t.integer  "company_number",                       null: false
    t.integer  "company_type",   limit: 1, default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                 null: false
    t.string   "password"
    t.integer  "uid",        limit: 8
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["name"], name: "index_users_on_name", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree
  add_index "users", ["uid"], name: "uid", unique: true, using: :btree

end
