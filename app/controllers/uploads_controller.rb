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
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    if @upload.destroy
      flash[:success] = "File successfully removed from our system"
    else
      flash[:error] = "Something went wrong while deleting your file"
    end
      redirect_to root_url
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
