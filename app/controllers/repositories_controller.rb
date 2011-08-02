class RepositoriesController < ApplicationController
  # GET /repositories
  # GET /repositories.xml
  def index
    @repositories = Repository.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @repositories }
    end
  end

  # GET /repositories/1
  # GET /repositories/1.xml
  def show
    @commits = Commit.paginate(:page => params[:page], :conditions=>{:repository_id => params[:id]})

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @commits }
    end
  end
end