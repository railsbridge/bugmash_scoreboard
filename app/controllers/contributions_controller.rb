class ContributionsController < ApplicationController
  before_filter :login_required

  def new
    @contribution = Contribution.new
    @participants = Participant.all(:select => 'id, name')
  end
end
