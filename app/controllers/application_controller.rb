class ApplicationController < ActionController::Base
  private
  def current_user
    User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, notice: 'Please sign in first!'
    end
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
end
