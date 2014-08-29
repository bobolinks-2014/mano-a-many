class UserSquaring < ActiveRecord::Base
  belongs_to :user
  belongs_to :squaring_event

end
