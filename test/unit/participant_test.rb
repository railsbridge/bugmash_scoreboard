require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantTest < ActiveSupport::TestCase
  should_have_indices :email, :persistence_token, :perishable_token, [:name, :lighthouse_id]

  should_validate_presence_of :name

  should_have_many :actions

  context '.find_author' do
    setup { Factory(:participant, :lighthouse_id => 'cowboy', :github_id => 'baldie') }
    
    should 'find the participant by #name' do
      assert Participant.find_author('John McClane')
    end

    should 'find the participant by #lighthouse_id' do
      assert Participant.find_author('cowboy')
    end

    should 'find the participant by #github_id' do
      assert Participant.find_author('baldie')
    end
  end
end
