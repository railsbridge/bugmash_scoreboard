class TrackersController < ApplicationController
  before_filter :login_required

  def index
    @trackers = Tracker.all.paginate(:page => params[:page], :per_page => 25)
  end
end
