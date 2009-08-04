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

  def sign_user_in
    @user = Factory(:user) unless defined?(@user)

    visit signin_path
    fill_in :email, :with => @user.email
    fill_in :password, :with => 'secret'
    click_button 'sign in'
  end
end
