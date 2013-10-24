class AdministratorPagesController < ApplicationController
  before_filter :signed_in_administrator

  def home
  end


  private

  def signed_in_administrator
    redirect_to admin_signin_path, notice: "Please sign in." unless admin_signed_in?
  end

end
