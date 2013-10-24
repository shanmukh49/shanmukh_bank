module SessionsHelper

  def sign_in(customer)
    cookies.permanent[:remember_token] = customer.remember_token
    current_customer = customer
  end

  def signed_in?
    !current_customer.nil?
  end

  def current_customer=(customer)
    @current_customer = customer
  end

  def current_customer
    @current_customer ||= customer_from_remember_token
  end

  def current_customer?(customer)
    customer == current_customer
  end

  def sign_out
    current_customer = nil
    cookies.delete(:remember_token)
  end

  private

  def customer_from_remember_token
    remember_token = cookies[:remember_token]
    Customer.find_by_remember_token(remember_token) unless remember_token.nil?
  end
end
