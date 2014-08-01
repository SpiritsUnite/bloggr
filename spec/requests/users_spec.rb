require 'rails_helper'

RSpec.describe "User Pages", :type => :request do

  subject { page }

  describe "sign up" do
    before { visit signup_path }

    it { should have_content("Sign up") }

    context "with valid information" do
      before do
        fill_in "Username", :with => "aoeu"
        fill_in "Email",    :with => "test@example.com"
        fill_in "Password", :with => "Foobar"
        fill_in "Password confirmation", :with => "Foobar"
      end

      it "should add the user to the database" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

      context "after clicking button" do
        before { click_button "Sign up" }
        it { should have_content "Success" }
      end
    end

    context "with invalid information" do
      it "should display errors" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end
  end
end
