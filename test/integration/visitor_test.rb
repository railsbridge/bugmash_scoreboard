require File.join(File.dirname(__FILE__), '..', 'test_helper')

class VisitorTest < ActionController::IntegrationTest
  context 'A visitor to the site' do
    setup { @participant = Factory(:participant) }

    should 'see a list of Participants' do
      visit root_path
      assert_contain 'John McClane'
    end

    should "be able to see Participant's Actions" do
      visit root_path
      click_link 'John McClane'
      assert_equal participant_path(@participant), path
    end
  end
end
