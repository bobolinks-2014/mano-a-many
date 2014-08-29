class Transaction < ActiveRecord::Base 

  belongs_to :debtor, :class_name => "User"
  belongs_to :creditor, :class_name => "User"
  belongs_to :squaring_event

  validates :amount, :presence => true
  validates :description, :presence => true
  validates :debtor_id, :presence => true
  validates :creditor_id, :presence => true


  #--- necessary getter for the radio buttons --#
  def borrower
  end

  def friend_email
  end
  
end