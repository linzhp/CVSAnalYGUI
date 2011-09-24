class CommitsController < ApplicationController

  # GET /commits/1
  def show
    @actions = Action.paginate(:page => params[:page], :per_page => 10,
     :conditions=>{:commit_id => params[:id]})
    @cmt = Commit.find(params[:id])
    session[:next_commits].delete(@cmt) if session[:next_commits]
    user_id = session[:user_id]
    unless user_id
      redirect_to :users
    end
    @feedback = UserFeedback.find(:first,
     :conditions=>{:commit_id=>params[:id], :user_id=>user_id})
    unless @feedback
      @feedback = UserFeedback.new(:commit_id=>params[:id], :user_id=>user_id)
    end
  end

  # PUT /commits/1
  # PUT /commits/1.xml
  def update
    feedback.is_bug_fix = params[:commit][:is_bug_fix]

    respond_to do |format|
      if feedback.save
        format.html { redirect_to(@commit.repository, :notice => 'Commit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @commit.errors, :status => :unprocessable_entity }
      end
    end
  end

end
