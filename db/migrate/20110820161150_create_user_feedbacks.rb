class CreateUserFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :user_feedbacks do |t|
      t.references :user
      t.references :commit
      t.boolean :buggy
      t.boolean :is_bug_fix
      t.timestamps
    end
  end

  def self.down
    drop_table :user_feedbacks
  end
end
