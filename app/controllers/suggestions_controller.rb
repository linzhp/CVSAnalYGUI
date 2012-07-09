class SuggestionsController < ApplicationController
  def show
    actions = Actions.select("file_id, max(commit_id), current_file_path").
      where(:conditions=>["commit_id<=?", params[:id]]).
      group("file_id").
      paginate(:page => params[:page],per_page=>30)
  end
end
