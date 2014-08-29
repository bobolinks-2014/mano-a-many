class SquaringEvent < ActiveRecord::Base
  belongs_to :user_squaring
  belongs_to :user, :through => :user_squaring
end
