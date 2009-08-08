class TrackersController < ApplicationController
  before_filter :login_required

  def index
    @trackers = Tracker.all(:order => 'created_at DESC')
  end
end
