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

ActiveRecord::Schema.define(version: 20151117114157) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "file_transactions", force: :cascade do |t|
    t.string   "account"
    t.decimal  "amount"
    t.datetime "date"
    t.string   "reference"
    t.string   "t_type"
    t.string   "transaction_channel"
    t.string   "identifier"
    t.string   "account_name"
    t.string   "receipt_number"
    t.string   "bank_number"
    t.string   "check_number"
    t.string   "bank_account_number"
    t.string   "bank_routing_number"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "transaction_id"
    t.boolean  "imported",            default: false
  end

  add_index "file_transactions", ["transaction_id"], name: "index_file_transactions_on_transaction_id", using: :btree

  create_table "mambu_errors", force: :cascade do |t|
    t.string  "message"
    t.string  "code"
    t.integer "file_transaction_id"
  end

  add_index "mambu_errors", ["file_transaction_id"], name: "index_mambu_errors_on_file_transaction_id", using: :btree

  create_table "mambu_infos", force: :cascade do |t|
    t.string  "message"
    t.integer "file_transaction_id"
  end

  add_index "mambu_infos", ["file_transaction_id"], name: "index_mambu_infos_on_file_transaction_id", using: :btree

  create_table "tenants", force: :cascade do |t|
    t.string   "name"
    t.string   "user_key"
    t.datetime "remaining_time"
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "excel_file"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.uuid     "uuid",       default: "uuid_generate_v4()"
  end

end
