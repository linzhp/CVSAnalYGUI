class Commit < ActiveRecord::Base
  set_table_name 'scmlog'
  belongs_to :repository
end
