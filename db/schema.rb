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

ActiveRecord::Schema.define(version: 20141105181743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "addresses", force: true do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "category_items", force: true do |t|
    t.integer  "category_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "category_items", ["category_id"], name: "index_category_items_on_category_id", using: :btree
  add_index "category_items", ["item_id"], name: "index_category_items_on_item_id", using: :btree

  create_table "items", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status",             default: "active"
    t.integer  "store_id"
    t.hstore   "options"
  end

  add_index "items", ["store_id"], name: "index_items_on_store_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity"
    t.text     "options"
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open"
    t.string   "status"
    t.integer  "address_id"
    t.integer  "store_id"
  end

  add_index "orders", ["address_id"], name: "index_orders_on_address_id", using: :btree
  add_index "orders", ["store_id"], name: "index_orders_on_store_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "stores", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "slug"
  end

  add_index "stores", ["user_id"], name: "index_stores_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "password_digest"
    t.string   "email_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "screen_name"
    t.string   "role"
  end

end
