class SourceFile < ActiveRecord::Base
  set_table_name 'files'
  def last_action_before_commit commit_id
    all_actions = Action.where("file_id = ? AND commit_id <= ?", id, commit_id)
    last_action = nil
    all_actions.each do |a|
      if last_action.nil? or a.commit_id > last_action.commit_id
        last_action = a
      end
    end
    last_action
  end
end