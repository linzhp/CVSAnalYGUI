class Action < ActiveRecord::Base
  def self.inheritance_column
    nil
  end
  
  def action_type
    read_attribute :type
  end
  
  def file
    FilePath.where("file_id = ? AND commit_id <= ?", self.file_id, self.commit_id).order("commit_id DESC")[0].file_path
  end
end
