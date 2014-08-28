class User < ActiveRecord::Base
  has_many :debits, :foreign_key => :creditor_id, :class_name => "Transaction"
  has_many :credits, :foreign_key => :debtor_id, :class_name => "Transaction"
  has_many :user_squarings
end
