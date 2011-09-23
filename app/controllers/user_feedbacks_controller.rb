require 'net/http'

class UserFeedbacksController < ApplicationController
  NOTICE = "Thanks for giving feedback, please consider this commit now"
  def update
    @feedback = UserFeedback.find(params[:id])
    @feedback.update_attributes!(params[:user_feedback])
    redirect_to(next_commit, :notice=>NOTICE)
  end
  
  def create
    @feedback = UserFeedback.create!(params[:user_feedback])
    redirect_to(next_commit, :notice=>NOTICE)
  end
  
  def next_commit
    feedback_value = nil
    if @feedback.is_buggy] and @feedback.is_bug_fix
      feedback_value = 'is_both'
    elsif @feedback.is_buggy
      feedback_value = 'is_buggy'
    elsif @feedback.is_bug_fix
      feedback_value = 'is_bug_fix'
    else
      feedback_value = 'normal'
    end
    
    commit = @feedback.commit
    project_name = commit.repository.name
    if project_name.start_with?('lucene')
      project_name = 'lucene'
    end
    json = Net::HTTP.get("backend.drshivaji.com",
    "/process_feedback/user_id/#{@feedback.user_id}/rev_hash/#{commit.rev}/feedback_value/#{feedback_value}/project_name/#{project_name}/")
    rev = ActiveSupport::JSON.decode(json)["next_revision"]
    commit = Commit.where(:rev => rev)
  end
end
