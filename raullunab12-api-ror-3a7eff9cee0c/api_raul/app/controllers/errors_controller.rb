class ErrorsController < ApplicationController
  def file_not_found
  	respond_to do |format|
      format.html { render text: { status: 404 } }
      format.json { render json: { status: 404 } }
    end
  end

  def unprocessable
  	 respond_to do |format|
      format.html { render text: { status: 422 } }
      format.json { render json: { status: 422 } }
    end
  end

  def internal_server_error
  	respond_to do |format|
      format.html { render text: { status: 500 } }
      format.json { render json: { status: 500 } }
    end
  end
end
