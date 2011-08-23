class RepositoriesController < ApplicationController
  # GET /repositories
  # GET /repositories.xml
  def index
    @repositories = Repository.where("name not like 'lucene%'")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @repositories }
    end
  end

  # GET /repositories/1
  # GET /repositories/1.xml
  def show
    if params[:id] == 'lucene'
      @commits = Commit.paginate(:page => params[:page],
        :conditions=>"repository_id in (select id from repositories where name like 'lucene%')",
        :order=>:author_date)
    else
      @commits = Commit.paginate(:page => params[:page],
        :conditions=>{:repository_id => params[:id]},
        :order=>:author_date)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @commits }
    end
  end
  
end