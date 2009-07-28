require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantCanSignInAndSignOutTest < ActionController::IntegrationTest
  context 'a registered Participant' do
    should 'be able to sign in' do
      sign_participant_in
      assert_equal participant_path(@participant), path
    end

    should 'be able to sign out' do
      sign_participant_in
      visit edit_participant_path(@participant)
      click_link 'sign out'
      assert_equal signin_path, path
    end
  end
end
