class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def signed_in_user
    unless signed_in?
      flash[:error] = "You need to sign in first, to upload a file"
      redirect_to root_url 
    end
  end

  def authorized_user
    if current_user != Upload.find(params[:id]).user
      flash[:error] = "You are not authorized to have any access for this file"
      redirect_to root_url
    end
  end
end
