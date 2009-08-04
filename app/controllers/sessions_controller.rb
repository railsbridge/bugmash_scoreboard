class SessionsController < ApplicationController
  def new
    render
  end
  
  def create
    if user = User.authenticate(params[:email], params[:password])
      self.current_user = user
      flash[:notice] = 'Sign in successful.'
      redirect_to root_path
    else
      flash.now[:error] =  "Couldn't locate a user with those credentials"
      render :action => :new
    end
  end
end
