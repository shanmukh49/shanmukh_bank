class CustomerTransactionsController < ApplicationController
  # GET /customer_transactions
  # GET /customer_transactions.json
  def index
    @customer_transactions = CustomerTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customer_transactions }
    end
  end

  # GET /customer_transactions/1
  # GET /customer_transactions/1.json
  def show
    @customer_transaction = CustomerTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer_transaction }
    end
  end

  # GET /customer_transactions/new
  # GET /customer_transactions/new.json
  def new
    @customer_transaction = CustomerTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer_transaction }
    end
  end

  # GET /customer_transactions/1/edit
  def edit
    @customer_transaction = CustomerTransaction.find(params[:id])
  end

  # POST /customer_transactions
  # POST /customer_transactions.json
  def create
    @customer_transaction = CustomerTransaction.new(params[:customer_transaction])

    customer_id = params[:customer_transaction][:customer_id]
    recipient_customer_id = params[:customer_transaction][:recipient_customer_id]
    amount = params[:customer_transaction][:amount].to_f

    @customer = Customer.find(customer_id)

    if (@customer.account_balance < amount)
      if @customer_transaction.transaction_type == 0
        redirect_to transfer_money_path, notice: "Insufficient funds for transfer"
        return false
      elsif @customer_transaction.transaction_type == 1
        redirect_to pay_bill_path, notice: "Insufficient funds for transfer"
        return false
      end
    else
      @customer.decrease_balance(amount)
      @customer.save

      sign_in @customer

      if @customer_transaction.transaction_type == 0
        @recipient_customer = Customer.find(recipient_customer_id)
        if @recipient_customer.account_balance
          @recipient_customer.increase_balance(amount)
        else
          @recipient_customer.account_balance = amount
        end
        @recipient_customer.save
      end
    end

    if @customer_transaction.save
      redirect_to list_transactions_path, notice: 'Customer transaction was successfully created.'
    else
      if @customer_transaction.transaction_type == 0
        redirect_to list_transaction_path, error: @customer_transaction.errors
      elsif @customer_transaction.transaction_type == 1
        redirect_to list_transaction_path, error: @customer_transaction.errors
      end
    end
  end

  # PUT /customer_transactions/1
  # PUT /customer_transactions/1.json
  def update
    @customer_transaction = CustomerTransaction.find(params[:id])

    respond_to do |format|
      if @customer_transaction.update_attributes(params[:customer_transaction])
        format.html { redirect_to @customer_transaction, notice: 'Customer transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_transactions/1
  # DELETE /customer_transactions/1.json
  def destroy
    @customer_transaction = CustomerTransaction.find(params[:id])
    @customer_transaction.destroy

    respond_to do |format|
      format.html { redirect_to customer_transactions_url }
      format.json { head :no_content }
    end
  end
end
