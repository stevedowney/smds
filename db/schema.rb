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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120823161728) do

  create_table "comment_activities", :force => true do |t|
    t.integer  "quote_id",                      :null => false
    t.integer  "comment_id",                    :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "voted_up",   :default => false, :null => false
    t.boolean  "voted_down", :default => false, :null => false
    t.boolean  "favorited",  :default => false, :null => false
    t.boolean  "flagged",    :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "body",                :limit => 2000,                    :null => false
    t.integer  "author_id",                                              :null => false
    t.integer  "quote_id",                                               :null => false
    t.integer  "vote_up_count",                       :default => 0,     :null => false
    t.integer  "vote_down_count",                     :default => 0,     :null => false
    t.integer  "vote_net_count",                      :default => 0,     :null => false
    t.integer  "favorite_count",                      :default => 0,     :null => false
    t.integer  "flag_count",                          :default => 0,     :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at",                                             :null => false
    t.integer  "comment_number",                      :default => 0,     :null => false
    t.boolean  "deleted",                             :default => false, :null => false
    t.string   "deleted_by",          :limit => 20
    t.integer  "parent_id"
    t.integer  "child_comment_count",                 :default => 0,     :null => false
    t.integer  "depth",                               :default => 0,     :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 20
    t.string   "subject",    :limit => 60
    t.string   "body",       :limit => 2000
    t.string   "status",     :limit => 20,   :default => "new", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "quote_activities", :force => true do |t|
    t.integer  "quote_id",                         :null => false
    t.integer  "user_id",                          :null => false
    t.boolean  "voted_up",      :default => false, :null => false
    t.boolean  "voted_down",    :default => false, :null => false
    t.boolean  "favorited",     :default => false, :null => false
    t.boolean  "flagged",       :default => false, :null => false
    t.integer  "comment_count", :default => 0,     :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "quotes", :force => true do |t|
    t.integer  "owner_id"
    t.string   "who",                   :limit => 100,                 :null => false
    t.string   "text",                  :limit => 2000,                :null => false
    t.string   "context",               :limit => 2000
    t.integer  "vote_up_count",                         :default => 0, :null => false
    t.integer  "vote_down_count",                       :default => 0, :null => false
    t.integer  "vote_net_count",                        :default => 0, :null => false
    t.integer  "favorite_count",                        :default => 0, :null => false
    t.integer  "flag_count",                            :default => 0, :null => false
    t.integer  "comments_count",                        :default => 0, :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "twitter_update_id_str", :limit => 30
  end

  create_table "users", :force => true do |t|
    t.string   "username",                                  :null => false
    t.string   "email"
    t.string   "encrypted_password",                        :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
