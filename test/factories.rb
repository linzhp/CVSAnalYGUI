FactoryGirl.define do
  factory :scmlog, :class => Commit, :aliases =>[:commit] do
    is_bug_fix false
  end
  
  factory :hunk
  
  factory :hunk_blame
  
  factory :repository
  
  factory :patch
  
  factory :action
  
  factory :content
end