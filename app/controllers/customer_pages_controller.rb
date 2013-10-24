class CustomerPagesController < ApplicationController
  before_filter :signed_in_customer, only: [:edit, :update]
  before_filter :correct_customer, only: [:edit, :update]

  def home
    @customer = Customer.find(current_customer.id)
  end

  def transactions
    @customer_transactions = CustomerTransaction.find(:all,
                  :conditions => ["created_at > ? AND customer_id = ?", 6.months.ago, current_customer.id])
                  # { :customer_id => current_customer.id, "transaction_date > 6.months.ago" })

  end

  def transfer_money
    @customer_transaction = CustomerTransaction.new

    @customers = Customer.find(:all, :conditions => ["id != ?", current_customer.id])
#                      :include => [:id, :name],
  end

  def pay_bill
    @payees = Payee.all
    @customer_transaction = CustomerTransaction.new
  end

  def view_profile
    @customer = Customer.find(current_customer.id)
  end

  def edit_profile
    @customer = Customer.find(current_customer.id)
  end

  def update_profile
    @customer = Customer.find(params[:customer][:id])

    if @customer.update_attributes(params[:customer])
      sign_in @customer
      redirect_to view_profile_path, notice: 'Your profile was successfully updated.'
    else
      render action: "edit_profile"
    end
  end

  private

  def signed_in_customer
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end

  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to(root_path) unless current_customer?(@customer)
  end


end
