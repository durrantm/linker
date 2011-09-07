class InitialDb < ActiveRecord::Migration
  def self.up
    create_table "groups", :force => true do |t|
      t.string   "group_name",        :null => false
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "group_description"
    end

    create_table "links", :force => true do |t|
      t.string   "url_address",    :null => false
      t.string   "alt_text"
      t.integer  "group_id"
      t.integer  "position"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "version_number"
      t.datetime "content_date"
    end

    create_table "sessions", :force => true do |t|
      t.string   "session_id", :null => false
      t.text     "data"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
    add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

    create_table "users", :force => true do |t|
      t.string   "username"
      t.string   "pwd_hashed"
      t.string   "salt"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end

  def self.down
  end
end
