require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ActionTest < ActiveSupport::TestCase
  should_belong_to :participant

  should_validate_presence_of :lighthouse_id
  should_validate_numericality_of :lighthouse_id, :point_value
end
