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

ActiveRecord::Schema.define(version: 20140627232834) do

  create_table "budget_plans", force: true do |t|
    t.decimal  "budget_amount",        precision: 8, scale: 2
    t.datetime "deadline"
    t.integer  "recur_period"
    t.decimal  "salary",               precision: 8, scale: 2
    t.decimal  "food_budget",          precision: 8, scale: 2
    t.decimal  "finance_budget",       precision: 8, scale: 2
    t.decimal  "shopping_budget",      precision: 8, scale: 2
    t.decimal  "auto_budget",          precision: 8, scale: 2
    t.decimal  "entertainment_budget", precision: 8, scale: 2
    t.decimal  "other_budget",         precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "alert"
  end

  create_table "cart_tests", force: true do |t|
  end

  create_table "finance_items", force: true do |t|
    t.integer  "goal_id"
    t.integer  "temp_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "finance_plan_id"
    t.text     "description"
  end

  add_index "finance_items", ["finance_plan_id"], name: "index_finance_items_on_finance_plan_id"
  add_index "finance_items", ["goal_id"], name: "index_finance_items_on_goal_id"
  add_index "finance_items", ["temp_item_id"], name: "index_finance_items_on_temp_item_id"

  create_table "finance_plans", force: true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "maturity_date"
    t.integer  "recur_period"
    t.decimal  "amount"
    t.boolean  "budget_plan"
    t.boolean  "protection_plan"
    t.boolean  "emergency_plan"
    t.boolean  "college_plan"
    t.boolean  "retirement_plan"
    t.boolean  "investment_plan"
  end

  create_table "goals", force: true do |t|
    t.text     "goal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recur_budgets", force: true do |t|
    t.string   "title"
    t.decimal  "price"
    t.datetime "recur_deduction_date"
    t.string   "category"
    t.integer  "temp_budget_plan_id"
    t.boolean  "begin_or_end_of_month"
  end

  create_table "spendings", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price"
    t.datetime "transaction_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.integer  "user_id"
    t.string   "category"
  end

  create_table "temp_budget_plans", force: true do |t|
    t.decimal  "budget_amount",        precision: 8, scale: 2
    t.datetime "deadline"
    t.integer  "recur_period"
    t.decimal  "food_budget",          precision: 8, scale: 2
    t.decimal  "finance_budget",       precision: 8, scale: 2
    t.decimal  "shopping_budget",      precision: 8, scale: 2
    t.decimal  "auto_budget",          precision: 8, scale: 2
    t.decimal  "entertainment_budget", precision: 8, scale: 2
    t.decimal  "other_budget",         precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finished"
    t.integer  "alert_send_period"
    t.integer  "user_id"
  end

  create_table "temp_items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
