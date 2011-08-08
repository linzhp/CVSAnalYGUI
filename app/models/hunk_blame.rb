class HunkBlame < ActiveRecord::Base
  belongs_to :hunk
  belongs_to :bug_commit, :class_name => 'Commit'
end
