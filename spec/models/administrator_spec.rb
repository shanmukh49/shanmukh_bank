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

require 'spec_helper'


describe Administrator do

  before { @administrator = Administrator.new(name: "Example Administrator", username: "administrator",
                                    password: "foobar", password_confirmation: "foobar") }

  subject { @administrator }

  it { should respond_to(:name) }
  it { should respond_to(:username) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }

  it { should be_valid }

  describe "when name is not present" do
    before { @administrator.name = " " }
    it { should_not be_valid }
  end

  describe "when username is not present" do
    before { @administrator.username = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @administrator.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      administrator_with_same_username = @administrator.dup
      administrator_with_same_username.username = @administrator.username.upcase
      administrator_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @administrator.password = @administrator.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @administrator.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @administrator.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
    before { @administrator.save }
    let(:found_administrator) { Administrator.find_by_username(@administrator.username) }

    describe "with valid password" do
      it { should == found_administrator.authenticate(@administrator.password) }
    end

    describe "with invalid password" do
      let(:administrator_for_invalid_password) { found_administrator.authenticate("invalid") }

      it { should_not == administrator_for_invalid_password }
      specify { administrator_for_invalid_password.should be_false }
    end
  end

  describe "remember token" do
    before { @administrator.save }
    its(:remember_token) { should_not be_blank }
  end
end