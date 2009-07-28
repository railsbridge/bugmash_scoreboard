class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all

    respond_to do |format|
      format.html # index.html.erb
    end
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
end
