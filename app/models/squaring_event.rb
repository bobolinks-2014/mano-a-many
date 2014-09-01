class SquaringEvent < ActiveRecord::Base
  has_many :transactions
  has_many :user_squarings
  has_many :users, through: :user_squarings
  belongs_to :group

  attr_accessor :debtors, :creditors, :new_transactions

  def consolidated_transactions(debtors, creditors)
    @debtors = debtors
    @creditors = creditors
    @new_transactions = []
    until bal_is_zero?
      payment_match = ez_match || high_low_match
      create_transaction(payment_match)
      update_debtors_creditors(payment_match)
    end
    @new_transactions
  end

  def bal_is_zero?
    if group_balanced?
      users = @debtors.merge(@creditors)
      users.all? {|user, balance| balance < 0.00001}
    else
      raise ArgumentError, "This shit don't add up (your transactions do not sum to 0)"
    end
  end

  def group_balanced?
    users = @debtors.merge(@creditors)
    users.values.inject(:+) < 0.00001 #deals with weird ruby rounding error bs
  end

  def ez_match
    @debtors.each do |debtor, debtor_balance|
      next if debtor_balance == 0

      @creditors.each do |creditor, creditor_balance|
        if debtor_balance.abs == creditor_balance
          return payment_match = {debtor: debtor,
                                  creditor: creditor,
                                  bal: creditor_balance}
        end
      end
    end

    return nil
  end

  def high_low_match
    debtor = @debtors.max_by {|debtor, balance| balance.abs}[0]
    creditor = @creditors.max_by {|creditor, balance| balance}[0]
    balance = [ @creditors[creditor], @debtors[debtor].abs ].min

    return payment_match = {debtor: debtor,
                            creditor: creditor,
                            bal: balance}
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
    @new_transactions ||= []
    @new_transactions << trans

  end

  def update_debtors_creditors(payment_match)
    debtor = payment_match[:debtor]
    creditor = payment_match[:creditor]
    bal = payment_match[:bal]

    @debtors[debtor] += bal
    @creditors[creditor] -= bal
  end
end
