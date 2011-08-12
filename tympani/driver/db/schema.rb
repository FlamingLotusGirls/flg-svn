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

ActiveRecord::Schema.define(:version => 20110809210637) do

  create_table "poofer_sequences", :force => true do |t|
    t.integer  "poofer_id"
    t.integer  "sequence_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "firing_time"
    t.boolean  "firing"
  end

  create_table "poofers", :force => true do |t|
    t.integer  "board"
    t.integer  "relay"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sequences", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "steps"
    t.integer  "step_delay"
  end

end
