class Repository < ActiveRecord::Base
  def self.inheritance_column
    nil
  end
  
  def repo_type
    read_attribute :type
  end
end
