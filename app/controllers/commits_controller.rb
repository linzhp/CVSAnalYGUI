class CommitsController < ApplicationController

  # GET /commits/1
  def show
    @patch = Patch.find(:first, :conditions=>{:commit_id => params[:id]})
    @actions = Action.paginate(:page => params[:page], :per_page => 10, :conditions=>{:commit_id => params[:id]})
    @cmt = Commit.find(params[:id])
  end

  # PUT /commits/1
  # PUT /commits/1.xml
  def update
    @commit = Commit.find(params[:id])

    respond_to do |format|
      if @commit.update_attributes(params[:commit])
        format.html { redirect_to(@commit.repository, :notice => 'Commit was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "show" }
        format.xml  { render :xml => @commit.errors, :status => :unprocessable_entity }
      end
    end
  end

end
