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

ActiveRecord::Schema.define(:version => 20090731163807) do

  create_table "actions", :force => true do |t|
    t.integer  "participant_id"
    t.integer  "lighthouse_id"
    t.integer  "point_value"
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
    t.string   "email",                                  :null => false
    t.string   "name",                                   :null => false
    t.string   "location"
    t.string   "lighthouse_id"
    t.string   "github_id"
    t.integer  "score",               :default => 0
    t.boolean  "admin",               :default => false
    t.boolean  "active",              :default => true
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["active"], :name => "index_participants_on_active"
  add_index "participants", ["email"], :name => "index_participants_on_email"
  add_index "participants", ["name", "lighthouse_id"], :name => "index_participants_on_name_and_lighthouse_id"
  add_index "participants", ["perishable_token"], :name => "index_participants_on_perishable_token"
  add_index "participants", ["persistence_token"], :name => "index_participants_on_persistence_token"

end
