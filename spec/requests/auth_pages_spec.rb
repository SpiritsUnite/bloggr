require 'rails_helper'

RSpec.shared_examples "a successful sign in" do
  it { should_not have_title('Sign in') }
  it { should_not have_selector('div.alert.alert-danger') }
end

RSpec.describe "Authentication", :type => :request do

  subject { page }

  describe "sign in" do
    
    before { visit signin_path }

    it { should have_content("Sign in") }

    context "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Password", with: user.password
      end

      context "with email" do
        before do
          fill_in "Username/Email", with: user.email.upcase
          click_button "Sign in"
        end
        it_behaves_like "a successful sign in"
      end

      context "with username" do
        before do
          fill_in "Username/Email", with: user.username
          click_button "Sign in"
        end
        it_behaves_like "a successful sign in"
      end
    end

    context "with invalid information" do
      before do
        click_button "Sign in" 
      end

      it { should have_selector("div.alert.alert-danger") }
      it { should_not have_selector("div.alert.alert-success") }
      it { should have_title "Sign in" }
    end
  end
end
