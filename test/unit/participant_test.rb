require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantTest < ActiveSupport::TestCase
  should_have_indices [:name, :lighthouse_id], :active

  should_validate_presence_of :name

  should_have_many :actions

  context '.find_author' do
    setup { Factory(:participant, :lighthouse_id => 'cowboy', :github_id => 'baldie') }
    
    should 'find the participant by #name' do
      assert Participant.find_or_create('John McClane')
      assert_equal 1, Participant.count
    end

    should 'find the participant by #lighthouse_id' do
      assert Participant.find_or_create('cowboy')
      assert_equal 1, Participant.count
    end

    should 'find the participant by #github_id' do
      assert Participant.find_or_create('baldie')
      assert_equal 1, Participant.count
    end

    should 'create new participant if not found' do
      assert Participant.find_or_create('Bruce Dickenson')
      assert_equal 2, Participant.count
    end
  end
end
