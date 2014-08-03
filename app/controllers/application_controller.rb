class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  
  def add_notice(type, text)
    flash[:notice] ||= []
    flash[:notice] << [type, text]
  end

  def add_notice_now(type, text)
    flash.now[:notice] ||= []
    flash.now[:notice] << [type, text]
  end

  # Signed in session functions
  def signed_in?
    !current_user.nil?
  end
  helper_method :signed_in?

  def current_user
    @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
  end

  def check_sign_in
    unless signed_in?
      add_notice(:danger, "Please sign in")
      redirect_to signin_path
    end
  end

end
