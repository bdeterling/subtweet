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

ActiveRecord::Schema.define(:version => 20110605023525) do

  create_table "survey_choices", :force => true do |t|
    t.string  "choice",    :limit => 500, :null => false
    t.integer "survey_id",                :null => false
  end

  create_table "survey_responses", :force => true do |t|
    t.string  "screen_name1",     :limit => 50, :null => false
    t.string  "screen_name2",     :limit => 50
    t.integer "survey_choice_id",               :null => false
    t.string  "responder",        :limit => 50
  end

  create_table "surveys", :force => true do |t|
    t.string "question", :limit => 500, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "screen_name"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
  end

end
