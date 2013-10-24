class AdminSessionsController < ApplicationController

  def new
  end

  def create
    administrator = Administrator.find_by_username(params[:session][:username])
    if administrator && administrator.authenticate(params[:session][:password])
      admin_sign_in administrator
      redirect_to administrator_home_path
    else
      flash.now[:error] = 'Invalid username/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    admin_sign_out
    redirect_to root_path
  end

end
