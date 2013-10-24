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

class Customer < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation, :account_balance
  has_secure_password
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :allow_blank => true
  validates :password_confirmation, length: { minimum: 6 }, :allow_blank => true

  def increase_balance (amount)
    self.account_balance += amount
  end

  def decrease_balance (amount)
    self.account_balance -= amount
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
