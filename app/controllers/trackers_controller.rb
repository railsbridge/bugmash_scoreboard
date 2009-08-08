class TrackersController < ApplicationController
  before_filter :login_required

  def index
    @trackers = Tracker.paginate(:page => params[:page], :order => 'created_at DESC')
  end
end
