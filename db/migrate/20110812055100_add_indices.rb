class AddIndices < ActiveRecord::Migration
  def self.up
    add_index :hunk_blames, :bug_commit_id
    add_index :hunk_blames, :hunk_id
    add_index :hunks, :commit_id
  end

  def self.down
    remove_index :hunks, :commit_id
    remove_index :hunk_blames, :hunk_id
    remove_index :hunk_blames, :bug_commit_id
  end
end
