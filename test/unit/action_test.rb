require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  
  def setup
    @action1 = FactoryGirl.create(:action, :commit_id=>3, :file_id=>2)
    @content1 = FactoryGirl.create(:content, :commit_id=>3, :file_id=>2)    
  end
  
  test "get content" do
    assert_equal @content1, @action1.content
  end
end
