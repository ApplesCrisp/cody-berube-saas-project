class ApplicationController < ActionController::Base
  # The before action requires the specified method to run before any other action
  before_action :authorized
  
  # Helper methods allows the methods to be available to views
  helper_method :current_user
  helper_method :logged_in?

  # This will be used to determine if we have a current user logged in
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    # This uses implicit return. It will call the current user method
    # and check if it's the opposite of nil.
    !current_user.nil?
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end
end
