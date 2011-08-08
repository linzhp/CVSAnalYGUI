require 'set'

class Commit < ActiveRecord::Base
  set_table_name 'scmlog'
  belongs_to :repository
  has_many :hunk_blames, :foreign_key => 'bug_commit_id'
  
  def is_buggy
    bug_fixing_commits.size > 0
  end
  
  def bug_fixing_commits
    unless @bf_commits
      @bf_commits = Set.new
      hunk_blames.each do |hb|
        fixing_commit = hb.hunk.commit 
        if fixing_commit.is_bug_fix
          @bf_commits.add(fixing_commit)
        end
      end
    end
    return @bf_commits
  end
end
