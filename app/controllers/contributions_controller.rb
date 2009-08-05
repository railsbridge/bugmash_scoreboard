class ContributionsController < ApplicationController
  before_filter :login_required
  
  def index
    @contributions = Contribution.all(:order => 'updated_at DESC')
  end
  
  def new
    @contribution = Contribution.new
    @participants = Participant.all(:select => 'id, name')
  end

  def create
    @contribution = Contribution.new(params[:contribution])
    
    if @contribution.save
      flash[:notice] = 'Contribution created.'
      redirect_to contributions_path
    else
      render :new
    end
  end

  def edit
    @contribution = Contribution.find(params[:id])
    @participants = Participant.all(:select => 'id, name')
  end

  def update
    @contribution = Contribution.find(params[:id])
    if @contribution.update_attributes(params[:contribution])
      flash[:notice] = 'Contribution updated.'
      redirect_to contributions_path
    else
      render :edit
    end
  end
end
