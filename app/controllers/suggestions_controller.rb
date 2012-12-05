class SuggestionsController < ApplicationController
  def show
    @commit = Commit.find params[:id]
    @files = @commit.snapshot params[:page]
    @suggestion = Suggestion.find_by_rev @commit.rev
    
  end
end
