class Content < ActiveRecord::Base
  set_table_name 'content'
  belongs_to :commit

  def path
    action.current_file_path
  end
  
  def action
    Action.where(:commit_id => commit_id, :file_id => file_id)[0]
  end
end
