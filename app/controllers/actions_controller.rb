class ActionsController < ApplicationController
  def show
    @action = Action.find(params[:id])
    unless @action.patch
      render :not_found
    end
  end
  
end
