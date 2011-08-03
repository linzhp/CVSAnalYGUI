class ContentController < ApplicationController
  
  def show
    @content = Content.find(:first, 
    :conditions => {:commit_id => params[:commit_id], :file_id => params[:file_id]})
    unless @content
      render :not_found
    end
  end
end
