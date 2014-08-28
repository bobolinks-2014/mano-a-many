class User < ActiveRecord::Base
  has_many :debits, :foreign_key => :creditor_id, :class_name => "Transaction"
  has_many :credits, :foreign_key => :debtor_id, :class_name => "Transaction"
  # has_many :user_squarings

  has_secure_password

####NEEDS RSPEC#####

###SHOULD TAKE CITERIA, MAYBE AS A BLOCK
  def find_balance
    sum_debits - sum_credits
  end

###SHOULD TAKE CRITERIA FROM FIND_BALANCE
  def sum_debits
    self.debits.inject(0) do |sum, debit|
      sum + debit.amount
    end
  end

  def sum_credits
    self.credits.inject(0) do |sum, credit|
      sum + credit.amount
    end
  end

end
