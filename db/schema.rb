# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090804232454) do

  create_table "actions", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "lighthouse_id"
    t.integer  "point_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.text     "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.string   "name"
    t.text     "reader"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participants", :force => true do |t|
    t.string   "name",                            :null => false
    t.string   "location"
    t.string   "lighthouse_id"
    t.string   "github_id"
    t.integer  "score",         :default => 0
    t.boolean  "active",        :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["active"], :name => "index_participants_on_active"
  add_index "participants", ["name", "lighthouse_id"], :name => "index_participants_on_name_and_lighthouse_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
