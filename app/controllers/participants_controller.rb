class ParticipantsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :require_profile_owner, :only => [:edit, :update, :destroy]

  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def new
    @participant = Participant.new
  end

  def edit
    render
  end

  def create
    @participant = Participant.new(params[:participant])

    if @participant.save
      flash[:notice] = "You're signed up for the BugMash!"
      redirect_to(edit_participant_path(@participant))
    else
      render :action => "new"
    end
  end

  def update
    if @participant.update_attributes(params[:participant])
      flash[:notice] = 'Participant was successfully updated.'
      redirect_to(@participant)
    else
      render :action => "edit"
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to(participants_url)
  end

  private

  def require_profile_owner
    @participant = Participant.find(params[:id])
    unless current_user == @participant
      flash[:error] = 'Tsk, tsk, tsk. You can only edit your own profile.'
      redirect_to edit_participant_path(current_user)
    end
  end
end
