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

ActiveRecord::Schema.define(:version => 20110812055100) do

  create_table "action_files", :id => false, :force => true do |t|
    t.integer "file_id"
    t.integer "action_id",                :default => 0, :null => false
    t.string  "action_type", :limit => 1
    t.integer "commit_id"
  end

  create_table "actions", :force => true do |t|
    t.string  "type",              :limit => 1
    t.integer "file_id"
    t.integer "commit_id"
    t.integer "branch_id"
    t.string  "current_file_path"
    t.string  "patch"
  end

  add_index "actions", ["commit_id"], :name => "commit_id"
  add_index "actions", ["file_id"], :name => "file_id"
  add_index "actions", ["type"], :name => "action_type"

  create_table "actions_file_names", :id => false, :force => true do |t|
    t.integer "id",                                :default => 0, :null => false
    t.string  "type",          :limit => 1
    t.integer "file_id"
    t.text    "new_file_name", :limit => 16777215
    t.integer "commit_id"
  end

  create_table "branches", :force => true do |t|
    t.string "name"
  end

  create_table "content", :force => true do |t|
    t.integer "commit_id",                     :null => false
    t.integer "file_id",                       :null => false
    t.text    "content",   :limit => 16777215
    t.integer "loc"
    t.integer "size"
  end

  add_index "content", ["commit_id", "file_id"], :name => "commit_id", :unique => true
  add_index "content", ["commit_id"], :name => "commit_id_2"
  add_index "content", ["file_id"], :name => "file_id"

  create_table "features", :force => true do |t|
    t.integer "commit_id",                                           :null => false
    t.boolean "buggy",                            :default => false
    t.integer "file_copied",                      :default => 0
    t.integer "author_id"
    t.integer "commit_hour"
    t.integer "commit_day"
    t.integer "log_length",                       :default => 0
    t.integer "changed_LOC",                      :default => 0
    t.integer "ADDING_ATTRIBUTE_MODIFIABILITY",   :default => 0
    t.integer "ADDING_CLASS_DERIVABILITY",        :default => 0
    t.integer "ADDING_METHOD_OVERRIDABILITY",     :default => 0
    t.integer "ADDITIONAL_CLASS",                 :default => 0
    t.integer "ADDITIONAL_FUNCTIONALITY",         :default => 0
    t.integer "ADDITIONAL_OBJECT_STATE",          :default => 0
    t.integer "ALTERNATIVE_PART_DELETE",          :default => 0
    t.integer "ALTERNATIVE_PART_INSERT",          :default => 0
    t.integer "ATTRIBUTE_RENAMING",               :default => 0
    t.integer "ATTRIBUTE_TYPE_CHANGE",            :default => 0
    t.integer "CLASS_RENAMING",                   :default => 0
    t.integer "COMMENT_DELETE",                   :default => 0
    t.integer "COMMENT_INSERT",                   :default => 0
    t.integer "COMMENT_MOVE",                     :default => 0
    t.integer "COMMENT_UPDATE",                   :default => 0
    t.integer "CONDITION_EXPRESSION_CHANGE",      :default => 0
    t.integer "DECREASING_ACCESSIBILITY_CHANGE",  :default => 0
    t.integer "DOC_DELETE",                       :default => 0
    t.integer "DOC_INSERT",                       :default => 0
    t.integer "DOC_UPDATE",                       :default => 0
    t.integer "INCREASING_ACCESSIBILITY_CHANGE",  :default => 0
    t.integer "METHOD_RENAMING",                  :default => 0
    t.integer "PARAMETER_DELETE",                 :default => 0
    t.integer "PARAMETER_INSERT",                 :default => 0
    t.integer "PARAMETER_ORDERING_CHANGE",        :default => 0
    t.integer "PARAMETER_RENAMING",               :default => 0
    t.integer "PARAMETER_TYPE_CHANGE",            :default => 0
    t.integer "PARENT_CLASS_CHANGE",              :default => 0
    t.integer "PARENT_CLASS_DELETE",              :default => 0
    t.integer "PARENT_CLASS_INSERT",              :default => 0
    t.integer "PARENT_INTERFACE_CHANGE",          :default => 0
    t.integer "PARENT_INTERFACE_DELETE",          :default => 0
    t.integer "PARENT_INTERFACE_INSERT",          :default => 0
    t.integer "REMOVED_CLASS",                    :default => 0
    t.integer "REMOVED_FUNCTIONALITY",            :default => 0
    t.integer "REMOVED_OBJECT_STATE",             :default => 0
    t.integer "REMOVING_ATTRIBUTE_MODIFIABILITY", :default => 0
    t.integer "REMOVING_CLASS_DERIVABILITY",      :default => 0
    t.integer "REMOVING_METHOD_OVERRIDABILITY",   :default => 0
    t.integer "RETURN_TYPE_CHANGE",               :default => 0
    t.integer "RETURN_TYPE_DELETE",               :default => 0
    t.integer "RETURN_TYPE_INSERT",               :default => 0
    t.integer "STATEMENT_DELETE",                 :default => 0
    t.integer "STATEMENT_INSERT",                 :default => 0
    t.integer "STATEMENT_ORDERING_CHANGE",        :default => 0
    t.integer "STATEMENT_PARENT_CHANGE",          :default => 0
    t.integer "STATEMENT_UPDATE",                 :default => 0
    t.integer "UNCLASSIFIED_CHANGE",              :default => 0
  end

  add_index "features", ["commit_id"], :name => "commit_id", :unique => true

  create_table "file_copies", :force => true do |t|
    t.integer "to_id"
    t.integer "from_id"
    t.integer "from_commit_id"
    t.text    "new_file_name",  :limit => 16777215
    t.integer "action_id"
  end

  add_index "file_copies", ["action_id"], :name => "action_id"

  create_table "file_links", :force => true do |t|
    t.integer "parent_id"
    t.integer "file_id"
    t.integer "commit_id"
  end

  add_index "file_links", ["parent_id"], :name => "parent_id"

  create_table "file_paths", :force => true do |t|
    t.integer "commit_id"
    t.integer "file_id"
    t.string  "file_path"
  end

  add_index "file_paths", ["commit_id"], :name => "commit_id"
  add_index "file_paths", ["file_id"], :name => "file_id"
  add_index "file_paths", ["file_path", "id", "commit_id"], :name => "file_path_2"
  add_index "file_paths", ["file_path"], :name => "file_path"

  create_table "file_types", :force => true do |t|
    t.integer "file_id"
    t.text    "type",    :limit => 16777215
  end

  add_index "file_types", ["file_id"], :name => "file_id"

  create_table "files", :force => true do |t|
    t.string  "file_name"
    t.integer "repository_id"
  end

  add_index "files", ["file_name"], :name => "file_name"

  create_table "hunk_blames", :force => true do |t|
    t.integer "hunk_id"
    t.integer "bug_commit_id"
  end

  add_index "hunk_blames", ["bug_commit_id"], :name => "index_hunk_blames_on_bug_commit_id"
  add_index "hunk_blames", ["hunk_id"], :name => "index_hunk_blames_on_hunk_id"

  create_table "hunks", :force => true do |t|
    t.integer "file_id"
    t.integer "commit_id",                          :null => false
    t.integer "old_start_line"
    t.integer "old_end_line"
    t.integer "new_start_line"
    t.integer "new_end_line"
    t.boolean "bug_introducing", :default => false, :null => false
  end

  add_index "hunks", ["commit_id"], :name => "index_hunks_on_commit_id"
  add_index "hunks", ["file_id", "commit_id", "old_start_line", "old_end_line", "new_start_line", "new_end_line"], :name => "file_id", :unique => true

  create_table "patches", :force => true do |t|
    t.integer "commit_id"
    t.text    "patch",     :limit => 2147483647
  end

  add_index "patches", ["commit_id"], :name => "commit_id"

  create_table "people", :force => true do |t|
    t.string "name"
    t.string "email"
  end

  create_table "repositories", :force => true do |t|
    t.string "uri"
    t.string "name"
    t.string "type", :limit => 30
  end

  create_table "scmlog", :force => true do |t|
    t.text     "rev",           :limit => 16777215
    t.integer  "committer_id"
    t.integer  "author_id"
    t.datetime "commit_date"
    t.datetime "author_date"
    t.text     "message",       :limit => 2147483647
    t.boolean  "composed_rev"
    t.integer  "repository_id"
    t.boolean  "is_bug_fix",                          :default => false
  end

  add_index "scmlog", ["author_date"], :name => "author_date"
  add_index "scmlog", ["commit_date"], :name => "commit_date"
  add_index "scmlog", ["is_bug_fix", "repository_id", "commit_date"], :name => "is_bug_fix_2"
  add_index "scmlog", ["is_bug_fix"], :name => "is_bug_fix"
  add_index "scmlog", ["repository_id"], :name => "repository_id"

  create_table "tag_revisions", :force => true do |t|
    t.integer "tag_id"
    t.integer "commit_id"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
