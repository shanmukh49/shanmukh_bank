# == Schema Information
#
# Table name: customers
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  password_digest :string(255)
#  name            :string(255)
#  account_balance :decimal
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  remember_token  :string(255)
#

require 'spec_helper'

describe Customer do

  before { @customer = Customer.new(name: "Example Customer", username: "customer",
                                    password: "foobar", password_confirmation: "foobar",
                                    account_balance: 1000.0) }

  subject { @customer }

  it { should respond_to(:name) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:account_balance) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @customer.name = " " }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @customer.username = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @customer.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      customer_with_same_username = @customer.dup
      customer_with_same_username.username = @customer.username.upcase
      customer_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @customer.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @customer.save }
    let(:found_customer) { Customer.find_by_username(@customer.username) }

    describe "with valid password" do
      it { should == found_customer.authenticate(@customer.password) }
    end

    describe "with invalid password" do
      let(:customer_for_invalid_password) { found_customer.authenticate("invalid") }

      it { should_not == customer_for_invalid_password }
      specify { customer_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @customer.save }
    its(:remember_token) { should_not be_blank }
  end
end
