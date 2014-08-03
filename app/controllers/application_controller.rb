class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def add_notice(type, text)
    flash[:notice] ||= []
    flash[:notice] << [type, text]
  end

  def add_notice_now(type, text)
    flash.now[:notice] ||= []
    flash.now[:notice] << [type, text]
  end
end
