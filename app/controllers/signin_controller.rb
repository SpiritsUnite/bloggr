class SigninController < ApplicationController
	def new
	end

  def create
    user = User.find_by(username: params[:signin][:user]) ||
        User.find_by(["email LIKE ?", params[:signin][:user]])
    if user && user = user.authenticate(params[:signin][:password])
      session[:current_user_id] = user.id
      add_notice(:success, "You have successfully logged in")
      redirect_to root_path
    else
      add_notice_now(:danger, "Bad username/email or password")
      render action: 'new'
    end
  end

  def destroy

  end
end
