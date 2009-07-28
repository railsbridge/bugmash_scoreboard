class ParticipantSessionsController < ApplicationController
  before_filter :require_user, :only => :destroy

  def new
    @participant_session = ParticipantSession.new
  end
  
  def create
    @participant_session = ParticipantSession.new(params[:participant_session])
    if @participant_session.save
      redirect_back_or_default participant_path(@participant_session.participant)
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:success] = "Logout successful!"
    redirect_back_or_default login_path
  end
end
