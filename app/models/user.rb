class User < ActiveRecord::Base
  has_many :debits, :foreign_key => :creditor_id, :class_name => "Transaction"
  has_many :credits, :foreign_key => :debtor_id, :class_name => "Transaction"

  has_many :user_squarings
  has_many :squaring_events, :through => :user_squarings
  has_many :memberships
  has_many :groups, :through => :memberships

  has_secure_password

  def find_balance(transactions=nil)
    sum_debits(transactions) - sum_credits(transactions)
  end

  def sum_debits(transactions=nil)
    if transactions
      transactions.inject(0) do |sum, transaction|
        transaction.creditor_id == self.id ? transaction.amount + sum : sum
      end

    else
      self.debits.inject(0) do |sum, debit|
        (sum + debit.amount)
      end
    end
  end

  def sum_credits(transactions=nil)
    if transactions
      transactions.inject(0) do |sum, transaction|
        transaction.debtor_id == self.id ? transaction.amount + sum : sum
      end
    else
      self.credits.inject(0) do |sum, credit|
        (sum + credit.amount)
      end
    end
  end

end
