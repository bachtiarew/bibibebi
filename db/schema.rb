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

ActiveRecord::Schema.define(version: 20161108155759) do

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "avg",           limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "babysitter_skills", id: false, force: :cascade do |t|
    t.integer "babysitter_id", limit: 4
    t.integer "skill_id",      limit: 4
  end

  add_index "babysitter_skills", ["babysitter_id"], name: "index_babysitter_skills_on_babysitter_id", using: :btree
  add_index "babysitter_skills", ["skill_id"], name: "index_babysitter_skills_on_skill_id", using: :btree

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

  create_table "kids", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "gender",      limit: 255
    t.integer  "age",         limit: 4
    t.text     "description", limit: 65535
    t.integer  "ortu_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kids", ["parent_id"], name: "index_kids_on_ortu_id", using: :btree

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "overall_avg",   limit: 24,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ortus", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photos",     limit: 255
  end

  add_index "ortus", ["user_id"], name: "index_ortus_on_user_id", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id",      limit: 4
    t.integer  "rateable_id",   limit: 4
    t.string   "rateable_type", limit: 255
    t.float    "stars",         limit: 24,  null: false
    t.string   "dimension",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id",   limit: 4
    t.string   "cacheable_type", limit: 255
    t.float    "avg",            limit: 24,  null: false
    t.integer  "qty",            limit: 4,   null: false
    t.string   "dimension",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.text    "description", limit: 65535
    t.integer "score",       limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.string   "role",            limit: 255
    t.string   "firstname",       limit: 255
    t.string   "lastname",        limit: 255
    t.string   "gender",          limit: 255
    t.string   "phone_number",    limit: 255
    t.string   "bornplace",       limit: 255
    t.date     "borndate"
    t.text     "address",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
