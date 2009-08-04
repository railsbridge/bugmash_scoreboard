class ApplicationController < ActionController::Base
  include SimplestAuth::Controller

  helper :all
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation

  def login_message
    'Tsk. tsk. tsk. Stop being naughty.'
  end

  def access_denied
    flash[:notice] = login_message
    redirect_to participants_path
  end
end
