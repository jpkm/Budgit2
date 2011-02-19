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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110219172523) do

  create_table "accounts", :force => true do |t|
    t.integer  "year"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "club_id"
    t.string   "user_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_categories", :force => true do |t|
    t.boolean  "active"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credits", :force => true do |t|
    t.integer  "credit_category_id"
    t.integer  "date"
    t.integer  "account_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debit_categories", :force => true do |t|
    t.boolean  "active"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "debits", :force => true do |t|
    t.text     "item_purchased"
    t.integer  "debit_category_id"
    t.text     "reason"
    t.integer  "nunber_of_consumers"
    t.text     "names_of_consumers"
    t.integer  "date_purchased"
    t.integer  "account_id"
    t.integer  "amount"
    t.integer  "reimbursement_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.boolean  "active"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
