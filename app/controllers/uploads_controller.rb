class UploadsController < ApplicationController
  before_action :signed_in_user
  before_action :authorized_user, only: [:show, :destroy, :download]

  def new
    @upload = current_user.uploads.build
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def create
    @upload = current_user.uploads.build(upload_params)
    if @upload.save
      flash[:success] = "#{@upload.name} successsfully uploaded"
      redirect_to file_upload_path
    else
      render 'new'
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy
      flash[:success] = "File successfully removed from our system"
      redirect_to file_upload_path
      # later change above to path of user's file listing
    else
      flash[:error] = "Something went wrong while deleting your file"
      redirect_to root_url
    end
  end

  def download
    # download_upload_path
    @upload = Upload.find(params[:id])
    send_file @upload.path, type: @upload.content_type, disposition: 'attachment'
  end

  private
  def upload_params
    params.require(:upload).permit(:path)
  end

end
