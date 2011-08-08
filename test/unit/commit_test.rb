require 'test_helper'

class CommitTest < ActiveSupport::TestCase

  def setup
    @commit2 = FactoryGirl.create(:scmlog, :is_bug_fix => true)
    hunk1 = FactoryGirl.create(:hunk, :commit => @commit2)
    hunk_blame1 = FactoryGirl.build(:hunk_blame, :hunk => hunk1)
    @commit1 = FactoryGirl.create(:scmlog)
    @commit1.hunk_blames << hunk_blame1    
  end
  
  test "is buggy" do
    assert_equal true, @commit1.is_buggy
    assert_equal false, @commit2.is_buggy
  end
  
  test "bug fixing commits" do
    assert_equal @commit2.id, @commit1.bug_fixing_commits[0].id
  end
  
  test "bug introducing commits" do
    assert_equal @commit1.id, @commit2.bug_introducing_commits[0].id
  end
end
