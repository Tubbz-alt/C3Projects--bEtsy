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

ActiveRecord::Schema.define(version: 20150715171650) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity",   null: false
    t.integer  "order_id",   null: false
    t.integer  "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "address1",                        null: false
    t.string   "address2"
    t.string   "city",                            null: false
    t.string   "state",                           null: false
    t.string   "zipcode",                         null: false
    t.string   "card_last_4",                     null: false
    t.datetime "card_exp",                        null: false
    t.string   "status",      default: "pending", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "description"
    t.integer  "price",                     null: false
    t.string   "photo_url",                 null: false
    t.integer  "inventory",                 null: false
    t.string   "active",      default: "t", null: false
    t.integer  "user_id",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating",      null: false
    t.string   "description"
    t.integer  "product_id",  null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
