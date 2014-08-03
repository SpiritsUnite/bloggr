class SigninController < ApplicationController
	def new
	end

  def create
    user = User.find_by(username: params[:signin][:user]) ||
        User.find_by(email: params[:signin][:user])
    if user && user = user.authenticate(params[:signin][:password])
      session[:current_user_id] = user.id
      add_notice(:success, "You have successfully sigend in")
      redirect_to root_path
    else
      add_notice_now(:danger, "Bad username/email or password")
      render action: 'new'
    end
  end

  def destroy
    @_current_user = session[:current_user_id] = nil
    add_notice(:success, "You have successfully signed out")
    redirect_to root_url
  end
end
