class Action < ActiveRecord::Base
  belongs_to :commit
  
  def self.inheritance_column
    nil
  end
  
  def action_type
    read_attribute :type
  end
  
  def patch
    Patch.find(:first, :conditions=>{:commit_id=>commit_id, :file_id=>file_id})
  end
  
  def content
    Content.find(:first, :conditions=>{:commit_id=>commit_id, :file_id=>file_id})
  end
end
