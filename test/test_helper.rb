ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'webrat'

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit unless include?(RR::Adapters::TestUnit)

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  def sign_participant_in
    @participant = Factory(:participant) unless defined?(@participant)
    visit signin_path
    fill_in 'Email', :with => @participant.email
    fill_in 'Password', :with => 'sekrit'
    click_button 'sign in'
  end
end
