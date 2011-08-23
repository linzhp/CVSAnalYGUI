class CreateUserFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :user_feedbacks do |t|
      t.references :user, :null => false
      t.references :commit, :null => false
      t.boolean :buggy, :default => false
      t.boolean :is_bug_fix, :default => false
      t.timestamps
    end
    add_index :user_feedbacks, [:user_id, :commit_id], :unique => true
    add_index :user_feedbacks, :commit_id
  end

  def self.down
    drop_table :user_feedbacks
  end
end
