class TrackersController < ApplicationController
  before_filter :login_required

  def index
    @trackers = Tracker.not_processed
  end
end
