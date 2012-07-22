class TestLoginController < ApplicationController
  
  before_filter { raise unless %w(test development).include?(Rails.env)}
  
  skip_before_filter :authenticate, :apply_user_settings, :only => [:new, :create]
  
  def create
    user = User.find_by_username!(params.fetch(:username))
    if user.valid_password?(params.fetch(:password))
      reset_session
      sign_in user, :event => :authentication #, :bypass => true 
      render :text => "Test Login Successful"
    else
      flash.alert = t('.message.login_failure')
      redirect_to new_user_session_path
    end
  end
  
end