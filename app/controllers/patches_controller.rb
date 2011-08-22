class PatchesController < ApplicationController
  # GET /patches/1
  # GET /patches/1.xml
  def show
    @patch = Patch.find(params[:id])

    unless @patch
      render :not_found
    end
  end

end
