require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantCanUpdateProfileTest < ActionController::IntegrationTest
  context 'a registered Participant' do
    setup { sign_participant_in }
    
    should 'be allowed to update own profile' do
      assert_equal 'jmmclane', @participant.github_id
      assert_equal 'jmmclane', @participant.lighthouse_id

      visit edit_participant_path(@participant)

      fill_in 'GitHub ID', :with => 'cowboy'
      fill_in 'Lighthouse ID', :with => 'cowboy'
      click_button 'update profile'
      
      @participant.reload
      assert_equal 'cowboy', @participant.github_id
      assert_equal 'cowboy', @participant.lighthouse_id
    end

    should "not be allowed to edit another Participant's profile" do
      the_bad_guy = Factory(:participant, :name => 'Hans Gruber')
      
      visit edit_participant_path(the_bad_guy)
      
      assert_equal edit_participant_path(@participant), path
    end
  end
end
