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

ActiveRecord::Schema.define(version: 20141018185857) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contexts", force: true do |t|
    t.string  "name",                     null: false
    t.boolean "built_in", default: false, null: false
  end

  create_table "projects", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "body",                       null: false
    t.integer  "project_id"
    t.integer  "context_id"
    t.boolean  "complete",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["context_id"], name: "index_tasks_on_context_id", using: :btree

  create_table "words", force: true do |t|
    t.string  "element", null: false
    t.integer "times",   null: false
  end

end
