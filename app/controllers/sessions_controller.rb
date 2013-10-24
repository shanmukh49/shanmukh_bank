class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by_username(params[:session][:username])
    if customer && customer.authenticate(params[:session][:password])
      sign_in customer
      redirect_to customer_home_path
    else
      flash.now[:error] = 'Invalid username/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
