require 'leveldb'

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
    db = LevelDB::DB.new Rails.application.config.leveldb_dir
    keys = db.keys

    for v in db.values
      data = ActiveSupport::JSON.decode v
      if data['predicted_keywords'].empty?
        keys.delete data['rev']
      end
    end

    if params[:id] == 'lucene'
      @commits = Commit.paginate(:page => params[:page],
        :conditions=>["repository_id in (select id from repositories where name like 'lucene%') and rev in (?)", keys],
        :order=>:author_date)
      @repository = Repository.new :name => 'Lucene'
    else
      @repository = Repository.find params[:id]
      @commits = Commit.paginate(:page => params[:page],
        :conditions=>["repository_id = ? and rev in (?) ",params[:id], keys],
        :order=>:author_date)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @commits }
    end
  end
  
end