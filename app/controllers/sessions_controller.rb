class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy

  def new
    render
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      self.current_user = user
      flash[:notice] = 'You are now signed in.'
      redirect_to root_path
    else
      flash.now[:error] =  "Couldn't locate a user with those credentials"
      render :action => :new
    end
  end

  def destroy
    clear_session
    flash[:notice] = 'You have signed out.'
    redirect_to root_path
  end
end
