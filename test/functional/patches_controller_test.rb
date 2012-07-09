require 'test_helper'

class PatchesControllerTest < ActionController::TestCase
  setup do
    @commit = FactoryGirl.create(:scmlog)
    @patch = FactoryGirl.create(:patch, :file_id=>1, :commit=>@commit)
  end

  test "should show patch" do
    get :show, :id => @patch.to_param
    assert_response :success
  end

end
