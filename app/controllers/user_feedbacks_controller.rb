require 'net/http'

class UserFeedbacksController < ApplicationController
  NOTICE = "Thanks for giving feedback"
  def update
    @feedback = UserFeedback.find(params[:id])
    @feedback.update_attributes!(params[:user_feedback])
    redirect_to(@feedback.commit, :notice=>NOTICE)
  end
  
  def create
    @feedback = UserFeedback.create!(params[:user_feedback])
    redirect_to(@feedback.commit, :notice=>NOTICE)
  end
  
  def backend_process
    feedback_value = nil
    feedback = UserFeedback.find(params[:id])
    if feedback.buggy and feedback.is_bug_fix
      feedback_value = 'is_both'
    elsif feedback.buggy
      feedback_value = 'is_buggy'
    elsif feedback.is_bug_fix
      feedback_value = 'is_bug_fix'
    else
      feedback_value = 'normal'
    end
    commit = feedback.commit
    project_name = commit.repository.name
    if project_name.start_with?('lucene')
      project_name = 'lucene'
    end
    path = "/process_feedback/user_id/#{feedback.user_id}/rev_hash/#{commit.rev}/feedback_value/#{feedback_value}/project_name/#{project_name}/"
    logger.info path 
    http = Net::HTTP.new("67.169.175.131",8000)
    http.read_timeout=500
    res = http.get(path)
    if res.class == Net::HTTPOK
      @json = res.read_body
      logger.info @json
      rev = ActiveSupport::JSON.decode(@json)["next_revision"]
      commit = Commit.find(:first, :conditions=>{:rev => rev})
      session[:next_commits] = Set.new unless session[:next_commits]
      session[:next_commits] << commit
      logger.debug session[:next_commits].size
    else
      render :js => "alert('Get next commit failed because: #{res.inspect}');"      
    end
  end
end
