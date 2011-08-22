class Patch < ActiveRecord::Base
  belongs_to :commit
  
  def bug_introducing_patches
    bug_commits = commit.bug_introducing_commits
    patches = []
    for c in bug_commits
      p = Patch.find(:first, :conditions=>{:commit_id => c.id, :file_id => file_id})
      patches << p if p
    end
    patches
  end
end
