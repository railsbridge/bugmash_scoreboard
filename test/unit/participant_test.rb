require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantTest < ActiveSupport::TestCase
  should_have_indices :email, :persistence_token, :perishable_token

  should_validate_presence_of :name

  should_have_many :actions
end
