class SuggestionsController < ApplicationController
  def show
    @commit = Commit.find params[:id]
    @files = @commit.snapshot params[:page]
  end
end
