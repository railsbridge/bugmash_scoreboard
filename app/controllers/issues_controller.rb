class IssuesController < ApplicationController
  before_filter :login_required, :only => [:index, :edit, :update]

  def index
    @issues = Issue.all(:conditions => {:fixed => false})
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.create(params[:issue])

    if @issue.save
      flash[:notice] = "We hear ya. We'll look into it."
      redirect_to participants_path
    else
      render :new
    end
  end

  def update
    @issue = Issue.find(params[:id])
    
    if @issue.update_attributes(params[:issue])
      redirect_to issues_path
    else
      render :new
    end
  end

  def edit
    @issue = Issue.find(params[:id])
  end
end
