require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AdminToolsTest < ActionController::IntegrationTest
  context 'An administrator' do
    setup { sign_user_in }
  
    should 'be able to sign in' do
      assert_contain 'Sign in successful.'
      assert_equal root_path, path
    end
    
    should 'be able to sign out' do
      click_link 'sign out'
      assert_contain 'You have signed out.'
    end
    
    should_eventually 'be able to adjust a Participants score' do
    
    
    end
  end
end
