require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ActionTest < ActiveSupport::TestCase
  should_belong_to :participant
end
