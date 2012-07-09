class ContentController < ApplicationController
  
  def show
    @content = Content.find(params[:id])
    unless @content
      render :not_found
    end
  end
end
