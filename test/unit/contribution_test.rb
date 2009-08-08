require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Entry
  attr_accessor :author, :content, :title

  def initialize(author = nil, title = nil, content = nil)
    self.author = author
    self.title = title
    self.content = content
  end
end

class ContributionTest < ActiveSupport::TestCase
  should_belong_to :participant

  should_validate_presence_of :lighthouse_id
  should_validate_numericality_of :lighthouse_id, :point_value
  should_have_named_scope :dummy

  context '.new_ticket?' do
    should 'be true if the action is for a new ticket' do
      assert Contribution.new_ticket?(2999)
    end

    should 'be false if we have an action with a higher lighthouse id' do
      Contribution.create!(:lighthouse_id => 2999, :point_value => 25)
      assert ! Contribution.new_ticket?(2999)
    end
  end

  context '.up_or_down_vote?' do
    should 'detect an up vote' do
      assert Contribution.up_or_down_vote?('I give this a +1')
    end

    should 'detect a down vote' do
      assert Contribution.up_or_down_vote?('I give this a -1')
    end

    should 'not find a vote if one is not there' do
      assert ! Contribution.up_or_down_vote?('This is awesome.')
    end
  end
  
  context '.patch?' do
    should 'detect a patch' do
      assert Contribution.patch?("I've attached a patch")
    end
  end
  
  context '.extract_ticket_id' do
    should 'pull out the Lighthouse ticket id from title' do
      assert_equal 3000, Contribution.extract_ticket_id(Entry.new('John McClane', 'Do you really think you have a chance against us, Mr. Cowboy? [#3000]', 'Yippee-ki-yay'))
    end

    should 'pull the ticket out of the content if not found in the title' do
      assert_equal 2661, Contribution.extract_ticket_id(Entry.new('John McClane', 'Something is broken', 'Ruby 1.9: fix Content-Length for multibyte send_data streaming [#2661 state:resolved]'))
    end
  end
  
  context 'processing entries' do
    setup do
      @participant = Factory(:participant)
      Contribution.create!(:lighthouse_id => 2999, :point_value => 25)
    end
    
    should 'add the value to Participant#score' do
      Contribution.process_entries([Entry.new(@participant.name, 'I broke something [#3000]', 'Yippee-ki-yay')])
      @participant.reload
      assert_equal 50, @participant.score
    end

    context 'for a new ticket' do
      should 'award correct point value for a new Lighthouse ticket' do
        Contribution.process_entries([Entry.new(@participant.name, 'Do you really think you have a chance against us, Mr. Cowboy? [#3000]', 'Yippee-ki-yay')])
        contribution = Contribution.last
        assert_equal 50, contribution.point_value
      end
    end
    
    should 'award 50 points for verified issue' do
      Contribution.process_entries([Entry.new(@participant.name, 'ActiveRecord needs more cowbell! [#2999]', 'I have verified the cowbell patch.')])

      assert_equal 50, Contribution.last.point_value
    end
      
    should 'award 50 points for marking a ticket as not reproducible' do
      Contribution.process_entries([Entry.new(@participant.name, 'ActiveRecord needs more cowbell! [#2999]', 'not-reproducible.')])

      assert_equal 50, Contribution.last.point_value
    end
    
    should 'award 100 points for a patch' do
      Contribution.process_entries([Entry.new(@participant.name, 'More cowbell! [#2999]', "I've attached a patch")])

      assert_equal 100, Contribution.last.point_value
    end

    should 'award 1000 points for a Changeset' do
      Contribution.process_entries([Entry.new(@participant.name, 'Something is broken', 'Ruby 1.9: fix Content-Length for multibyte send_data streaming [#2661 state:resolved]')])
      assert_equal 1000, Contribution.last.point_value
    end

    should 'award 25 points for up or down vote' do
      Contribution.process_entries([Entry.new(@participant.name, 'ActiveRecord needs more cowbell! [#2999]', '+1 for cowbell')])
      assert_equal 25, Contribution.last.point_value
    end
  end
end
