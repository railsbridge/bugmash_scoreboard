require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ParticipantCanSignInAndSignOutTest < ActionController::IntegrationTest
  context 'a registered Participant' do
    setup { @participant = Factory(:participant) }
    
    should 'be able to sign in' do
      visit signin_path
      fill_in 'Email', :with => @participant.email
      fill_in 'Password', :with => 'sekrit'
      click_button 'sign in'

      assert_equal participant_path(@participant), path
    end
  end
end
