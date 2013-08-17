ActiveRecord::Schema.define(:version => 20130816214943) do

  create_table "comments", :force => true do |t|
    t.integer  "link_id"
    t.integer  "parent_comment_id"
    t.text     "body"
    t.integer  "author_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "owner_id"
  end

  create_table "sub_join_links", :force => true do |t|
    t.integer  "sub_id"
    t.integer  "link_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subs", :force => true do |t|
    t.string   "name"
    t.integer  "moderator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_votes", :force => true do |t|
    t.integer  "link_id"
    t.integer  "user_id"
    t.integer  "vote_value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "session_token"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
