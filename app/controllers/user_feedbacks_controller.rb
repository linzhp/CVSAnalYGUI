class UserFeedbacksController < ApplicationController
  def update
    @feedback = UserFeedback.find(params[:id])
    @feedback.update_attributes!(params[:user_feedback])
    redirect_to(@feedback.commit, :notice=>"Thanks for giving feedback!")
  end
  
  def create
    @feedback = UserFeedback.create!(params[:user_feedback])
    redirect_to(@feedback.commit, :notice=>"Thanks for giving feedback!")
  end
end
