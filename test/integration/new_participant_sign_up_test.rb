require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NewParticipantSignUpTest < ActionController::IntegrationTest
  context 'a new Participant' do
    should 'be able to sign up' do
      visit signup_path

      fill_in 'Email', :with => 'larrybird@frenchlick.com'
      fill_in 'Name', :with => 'Larry Bird'
      fill_in 'Password', :with => 'sekrit'
      fill_in 'Password Confirmation', :with => 'sekrit'
      click_button 'Sign me up'

      assert_equal edit_participant_path(Participant.last), path
      assert_contain "You're signed up for the BugMash!"
    end
  end
end
