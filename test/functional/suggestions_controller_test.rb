require 'test_helper'

class SuggestionsControllerTest < ActionController::TestCase
  def setup
    FactoryGirl.create(:action, :commit_id=>1, :file_id=>1)
    FactoryGirl.create(:action, :commit_id=>2, :file_id=>1)
    FactoryGirl.create(:action, :commit_id=>1, :file_id=>2)
    FactoryGirl.create(:action, :commit_id=>3, :file_id=>2)
    FactoryGirl.create(:content, :commit_id=>3, :file_id=>2)
  end

  test "should show suggestion" do
    get :show, :id=>2
    
  end
end
