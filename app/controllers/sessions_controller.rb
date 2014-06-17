class SessionsController < ApplicationController
  def new
    # initiating a new session

  end

  def create
    # for signing in, set cookie session
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid email or password'
      render 'new'
    end
  end

  def destroy
    # for signout
    cookies.delete :remember_token
    self.current_user = nil
    redirect_to root_url
  end

end

