module AdminSessionsHelper

  def admin_sign_in(administrator)
    cookies.permanent[:remember_token] = administrator.remember_token
    current_administrator = administrator
  end

  def admin_signed_in?
    !current_administrator.nil?
  end

  def current_administrator=(administrator)
    @current_administrator = administrator
  end

  def current_administrator
    @current_administrator ||= administrator_from_remember_token
  end

  def admin_sign_out
    current_admin = nil
    cookies.delete(:remember_token)
  end

  private

  def administrator_from_remember_token
    remember_token = cookies[:remember_token]
    Administrator.find_by_remember_token(remember_token) unless remember_token.nil?
  end

end
