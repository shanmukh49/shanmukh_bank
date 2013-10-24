require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1',   text: 'Customer Sign in') }
    it { should have_selector('title', text: 'Customer Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Customer Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:customer) { FactoryGirl.create(:customer) }
      before { sign_in customer }

      it { should have_selector('title', text: "Bank of Kwantlen Online") }
      it { should have_link('Profile', href: view_profile_path) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in customers" do
      let(:customer) { FactoryGirl.create(:customer) }

      describe "in the Customer controller" do

        describe "visiting the edit page" do
          before { visit edit_customer_path(customer) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put customer_path(customer) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "for non-signed-in administrator" do
      let(:administrator) { FactoryGirl.create(:administrator) }

      describe "in the Administrator controller" do

        describe "visiting the edit page" do
          before { visit edit_administrator_path(administrator) }
          it { should have_selector('title', text: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put administrator_path(administrator) }
          specify { response.should redirect_to(admin_signin_path) }
        end
      end
    end

  end
end
