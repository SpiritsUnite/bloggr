require 'rails_helper'

RSpec.describe User, :type => :model do

	before do
		@user = User.new(username: "aoeu", password: "foobar",
                     password_confirmation: "foobar", email: "test@example.com")
	end

	subject { @user }

	it { should respond_to(:username) }
	it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
	it { should respond_to(:email) }

  it { should be_valid }

  describe "when username has spaces" do
    before { @user.username = "john doe" }
    it { should_not be_valid }
  end

  describe "when password does not match confirmation" do
    before { @user.password_confirmation = "different" }
    it { should_not be_valid }
  end

  describe "when password empty" do
    before do
      @user.password = ""
      @user.password_confirmation = " "
    end
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.email = "different@example.com"
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.username = "different"
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

end
