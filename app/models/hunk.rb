class Hunk < ActiveRecord::Base
  belongs_to :commit
  has_many :hunk_blames
end
