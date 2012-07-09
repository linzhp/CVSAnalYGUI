require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  test "should get path" do
    action = FactoryGirl.create(:action, :commit_id=>1, :file_id=>1, :current_file_path=>__FILE__)
    content = FactoryGirl.create(:content, :commit_id=>1, :file_id=>1)
    assert_equal action, content.action
    assert_equal __FILE__, content.path
  end
end
