require 'set'
require 'will_paginate/array'

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
  
  def snapshot page=1
    cache_key = "commit_#{id}_snapshot"
    contents = nil #  Rails.cache.read(cache_key)
    unless contents
      all_files = SourceFile.where(:repository_id => repository_id)
      contents = all_files.map do |f| 
        a = f.last_action_before_commit(id)
        a.content if a
      end
      contents.compact!
      Rails.cache.write(cache_key, contents)
    end
    contents.paginate :page=>page
  end
end
