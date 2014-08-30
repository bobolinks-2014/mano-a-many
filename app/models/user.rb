class User < ActiveRecord::Base
  has_many :debits, :foreign_key => :creditor_id, :class_name => "Transaction"
  has_many :credits, :foreign_key => :debtor_id, :class_name => "Transaction"

  has_many :user_squarings
  has_many :squaring_events, :through => :user_squarings
  has_many :memberships
  has_many :groups, :through => :memberships


  has_secure_password

  def find_balance(users=nil)
    sum_debits(users) - sum_credits(users)
  end

  def sum_debits(users=nil)
    if users
      self.debits.inject(0) do |sum, debit|
        (users.include? debit.debtor) ? (sum + debit.amount) : sum
      end
    else
      self.debits.inject(0) do |sum, debit|
        (sum + debit.amount)
      end
    end
  end

  def sum_credits(users=nil)
    if users
      self.credits.inject(0) do |sum, credit|
        (users.include? credit.creditor) ? (sum + credit.amount) : sum
      end
    else
      self.credits.inject(0) do |sum, credit|
        (sum + credit.amount)
      end
    end
  end

  def friend_email
  end

end
