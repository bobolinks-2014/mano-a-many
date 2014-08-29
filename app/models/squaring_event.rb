require 'pry'
class SquaringEvent < ActiveRecord::Base
  has_many :transactions
  has_many :user_squarings
  has_many :users, through: :user_squarings

  attr_accessor :group_bal_hash
  # def square
  #   @group_bal_hash = get_group_balance
  #   @transactions = []
  #   until bal_is_zero?
  #     match = ez_match || high_low_match
  #     create_transaction(match)
  #     update_group_hash(match)
  #   end
  #   @transactions
  # end



#   def get_group_balance
#     users = self.users
#     hash = Hash.new
#     users.each do |user|
#       hash[user] = user.find_balance(users)
#     end
#     hash
#     #takes collection of users
#     #returns a hash, where key: user (or user.id) and value: their balance within the group
#   end

  def bal_is_zero?
    if @group_bal_hash.values.inject(:+) == 0
      @group_bal_hash.all? {|k,v| v.zero?}
    else
      raise ArgumentError, "This shit don't add up (your transactions do not sum to 0)"
    end
  end

  def ez_match
    creditors = Hash.new
    debtors = Hash.new

    @group_bal_hash.each do |k,v|
      if v > 0
        creditors[k] = v
      elsif v < 0
        debtors[k] = v
      end
    end

    creditors.each do |creditorKey,creditorValue|
      debtors.each do |debtorKey, debtorValue|
        if creditorValue == debtorValue.abs
          return {debtor: debtorKey, creditor: creditorKey, bal: creditorValue}
        end
      end
    end
    nil
  end

#   def high_low_match
#     debtor_creditor = @group_bal_hash.minmax_by{|user, balance| balance}

#     debtor = debtor_creditor[0][0]
#     creditor = debtor_creditor[1][0]
#     bal = lowest_abs_balance(debtor_creditor)

#     {debtor: debtor, creditor: creditor, bal: bal}
#   end

#   def lowest_abs_balance(debtor_creditor)
#     debtor_creditor.min_by{|user, balance| balance.abs}[1]
#   end

#   def create_transaction(match)
#     # binding.pry
#     trans = Transaction.new(debtor_id: match[:debtor].id,
#                             creditor_id: match[:creditor].id,
#                             amount: match[:bal],
#                             squaring_event_id: self.id,
#                             approved: true,
#                             closed: false,
#                             description: "squaring event #{self.id}",
#                             private_trans: false)
#     @transactions << trans
#   end

#   def update_group_hash(match)
#     debtor = match[:debtor]
#     creditor = match[:creditor]
#     bal = match[:bal]
# # binding.pry
#     @group_bal_hash[debtor] += bal
#     @group_bal_hash[creditor] -= bal
#   end
end
