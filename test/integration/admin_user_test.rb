require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AdminUserTest < ActionController::IntegrationTest
  context 'An administrator' do
    setup { sign_user_in }
  
    should 'be able to sign in' do
      assert_contain 'You are now signed in.'
      assert_equal root_path, path
    end
    
    should 'be able to sign out' do
      click_link 'sign out'
      assert_contain 'You have signed out.'
      assert_equal root_path, path
    end
    
    should 'be able to adjust a Participants score' do
      participant = Factory(:participant)
      assert_equal 0, participant.score
      
      visit edit_participant_path(participant)
      fill_in 'Score', :with => '100'
      click_button 'Update'
      assert_equal participant_path(participant), path

      participant.reload
      assert_equal 100, participant.score
    end
  end
end
