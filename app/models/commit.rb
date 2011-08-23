require 'set'

class Commit < ActiveRecord::Base
  set_table_name 'scmlog'
  belongs_to :repository
  has_many :hunk_blames, :foreign_key => 'bug_commit_id'
  has_many :hunks
  has_many :user_feedbacks
  
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
    @bf_commits.to_a
  end
  
  def bug_introducing_commits
    unless @bi_commits
      @bi_commits = Set.new
      hunks.each do |h|
        h.hunk_blames.each do |hb|
          @bi_commits.add(hb.bug_commit)
        end
      end
    end
    @bi_commits.to_a
  end
  
  def num_buggy_feedbacks
    user_feedbacks.select{|uf| uf.buggy}.size
  end
  
  def num_not_buggy_feedbacks
    user_feedbacks.select{|uf| not uf.buggy}.size
  end

  def num_fix_feedbacks
    user_feedbacks.select{|uf| uf.is_bug_fix}.size
  end

  def num_not_fix_feedbacks
    user_feedbacks.select{|uf| not uf.is_bug_fix}.size
  end
end
