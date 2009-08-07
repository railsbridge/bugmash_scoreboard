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

    should 'not be able to edit a Participant' do
      visit edit_participant_path(@participant)
      assert_path participants_path
      assert_contain 'Tsk. tsk. tsk. Stop being naughty.'
    end

    should 'not be able to see list the Contributions' do
      visit contributions_path
      assert_path participants_path
      assert_contain 'Tsk. tsk. tsk. Stop being naughty.'
    end

    should 'be able to report a scoring issue' do
      assert Issue.count.zero?
      visit root_path
      click_link 'problem?'
      assert_path new_issue_path
      assert_have_no_selector :input, :type => 'checkbox'
      fill_in 'Your name', :with => 'John McClane'
      fill_in 'Email', :with => 'jmmclane@diehard.com'
      fill_in 'Lighthouse Number', :with => '3000'
      fill_in 'Details', :with => 'I want moar points.'
      click_button 'Send'
      assert_path participants_path
      assert_contain "We hear ya. We'll look into it."
      assert_equal 1, Issue.count
    end
  end
end
