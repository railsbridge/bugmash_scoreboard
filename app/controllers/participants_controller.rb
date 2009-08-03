class ParticipantsController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :destroy]
  before_filter :require_profile_owner, :only => [:edit, :update, :destroy]

  def index
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @participant = Participant.new

    respond_to do |format|
      format.html # new.html.erb
    end
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


    respond_to do |format|
      if @participant.update_attributes(params[:participant])
        flash[:notice] = 'Participant was successfully updated.'
        format.html { redirect_to(@participant) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to(participants_url) }
      format.xml  { head :ok }
    end
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
