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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120401215238) do

  create_table "administrators", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.string   "remember_token"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "customer_transactions", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "recipient_customer_id"
    t.integer  "payee_id"
    t.decimal  "amount",                :precision => 10, :scale => 0
    t.date     "transaction_date"
    t.integer  "transaction_type"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.string   "remember_token"
    t.decimal  "account_balance", :precision => 10, :scale => 0
  end

  add_index "customers", ["remember_token"], :name => "index_customers_on_remember_token"
  add_index "customers", ["username"], :name => "index_customers_on_username", :unique => true

  create_table "payees", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
