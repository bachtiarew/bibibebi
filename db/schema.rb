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

ActiveRecord::Schema.define(version: 20160913081043) do

  create_table "babysitters", force: :cascade do |t|
    t.string   "nik",         limit: 255
    t.string   "age",         limit: 255
    t.text     "description", limit: 65535
    t.integer  "user_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photos",      limit: 255
  end

  add_index "babysitters", ["user_id"], name: "index_babysitters_on_user_id", using: :btree

  create_table "table_skills", force: :cascade do |t|
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "role",            limit: 255
    t.string   "firstname",       limit: 255
    t.string   "lastname",        limit: 255
    t.string   "bornplace",       limit: 255
    t.date     "borndate"
    t.text     "address",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
