class UploadsController < ApplicationController
  before_action :authenticate_user!
  # make before callback for authorization
  
  def new
    @upload = Upload.new
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def create
    @upload = current_user.uploads.build(upload_params)
    if @upload.save
      debugger
    end
  end

  def destroy
  end

  def download
    # download_upload_path
    @upload = Upload.find(params[:id])
    send_file @upload.file.path, type: @upload.file.content_type, disposition: 'attachment'
  end

  private
  def upload_params
    params.require(:upload).permit(:file)
  end
end
