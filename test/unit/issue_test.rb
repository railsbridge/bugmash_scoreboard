require File.join(File.dirname(__FILE__), '..', 'test_helper')

class IssueTest < ActiveSupport::TestCase
  should_validate_presence_of :contributor_name, :details
  should_validate_numericality_of :lighthouse_id
end
