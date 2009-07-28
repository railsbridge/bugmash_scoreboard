require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantTest < ActiveSupport::TestCase
  should_have_indices :email, :persistence_token, :perishable_token
end
