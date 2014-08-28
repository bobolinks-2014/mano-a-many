class SquaringEvent < ActiveRecord::Base
  has_many :transactions
  has_many :user_squarings
end
