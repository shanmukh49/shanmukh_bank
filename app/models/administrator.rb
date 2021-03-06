# == Schema Information
#
# Table name: administrators
#
#  id              :integer         not null, primary key
#  username        :string(255)
#  password_digest :string(255)
#  name            :string(255)
#  remember_token  :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Administrator < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation
  has_secure_password
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
