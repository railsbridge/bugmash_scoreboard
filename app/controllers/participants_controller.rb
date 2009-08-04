class ParticipantsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :delete]

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
    @participant = Participant.find(params[:id])
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
    @participant = Participant.find(params[:id])
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
end
