require 'spec_helper'

describe "Customer Pages" do

  subject { page }

  describe "profile page" do
    let(:customer) { FactoryGirl.create(:customer) }
    before do
      sign_in customer
      visit view_profile_path
    end

    it { should have_selector('h2',    text: "Your Profile") }
    it { should have_selector('title', text: full_title(customer.name)) }
  end

  describe "edit" do
      let(:customer) { FactoryGirl.create(:customer) }
      before do
        sign_in customer
        visit edit_profile_path
      end

      describe "page" do
        it { should have_selector('h1',    text: "Update Customer Profile") }
        it { should have_selector('title', text: full_title("Update Customer Profile")) }
      end

      describe "with invalid information" do
        before do 
          fill_in "Username", with:  ''
          click_button "Update Customer"
        end
        it { should have_selector('h1',    text: "Update Customer Profile") }
        it { should have_selector('title', text: full_title("Update Customer Profile")) }
      end
    end
end
