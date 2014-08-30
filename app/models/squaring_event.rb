class SquaringEvent < ActiveRecord::Base
  has_many :transactions
  has_many :user_squarings
  has_many :users, through: :user_squarings

  attr_accessor :group_bal_hash
  attr_reader :transactions


  # def square
  #   @group_bal_hash = get_group_balance
  #   @transactions = []
  #   until bal_is_zero?
  #     payment_match = ez_match || high_low_match
  #     create_transaction(payment_match)
  #     update_group_hash(payment_match)
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
    if group_balanced?
      @group_bal_hash.all? {|user, balance| balance.zero?}
    else
      raise ArgumentError, "This shit don't add up (your transactions do not sum to 0)"
    end
  end

  def group_balanced?
    @group_bal_hash.values.inject(:+) == 0
  end

  def ez_match
    debtors, creditors = split_debitors_creditors

    debtors.each do |debtor_key, debtor_value|
      creditors.each do |creditor_key, creditor_value|

        if debtor_value.abs == creditor_value
          return {debtor: debtor_key, creditor: creditor_key, bal: creditor_value}
        end

      end
    end

    return nil
  end

  def split_debitors_creditors
    debtors = Hash.new
    creditors = Hash.new

    @group_bal_hash.each do |user, balance|
      if balance < 0
        debtors[user] = balance
      elsif balance > 0
        creditors[user] = balance
      end
    end

    return debtors, creditors
  end

  def high_low_match
    debtor_creditor = @group_bal_hash.minmax_by{|user, balance| balance}

    debtor = debtor_creditor[0][0]
    creditor = debtor_creditor[1][0]
    bal = lowest_abs_balance(debtor_creditor)

    {debtor: debtor, creditor: creditor, bal: bal}
  end

  def lowest_abs_balance(debtor_creditor)
    debtor_creditor.min_by{|user, balance| balance.abs}[1].abs
  end

  def create_transaction(payment_match)
    trans = Transaction.new(debtor_id: payment_match[:debtor].id,
                            creditor_id: payment_match[:creditor].id,
                            amount: payment_match[:bal],
                            squaring_event_id: self.id,
                            approved: true,
                            closed: false,
                            description: "squaring event #{self.id}",
                            private_trans: false)
    @transactions << trans
  end

  def update_group_hash(payment_match)
    debtor = payment_match[:debtor]
    creditor = payment_match[:creditor]
    bal = payment_match[:bal]

    @group_bal_hash[debtor] += bal
    @group_bal_hash[creditor] -= bal
  end

end
