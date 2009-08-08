class ParticipantsController < ApplicationController
  before_filter :login_required, :only => [:edit, :update, :delete]

  def index
    @participants = Participant.top_scorers.paginate(:page => params[:page], :per_page => 25)
    @latest_contributions = Contribution.last_five
    # we're using the seeded contribution as our timestamp
    @time_stamp = Contribution.dummy.first.updated_at 
  end

  def show
    @participant = Participant.find(params[:id], :include => :contributions)
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
