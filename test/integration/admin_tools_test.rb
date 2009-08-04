require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AdminToolsTest < ActionController::IntegrationTest
  context 'An administrator' do
    setup do
      @user = Factory(:user)
    end
  
    should 'be able to sign in' do
      visit signin_path

      fill_in :email, :with => @user.email
      fill_in :password, :with => 'secret'
      click_button 'sign in'

      assert_equal root_path, path
    end

    should 'be able to adjust a Participants score' do
    
    
    end
  end
end
