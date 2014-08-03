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

  private

  def current_user
    @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
  end
end
