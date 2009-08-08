class TrackersController < ApplicationController
  before_filter :login_required

  def index
    @trackers = Tracker.all.paginate(:order => 'created_at DESC' :page => params[:page], :per_page => 25)
  end
end
