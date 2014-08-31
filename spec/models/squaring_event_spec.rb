require 'rails_helper'
require_relative '../../app/models/squaring_event'

describe SquaringEvent do
  before do
    @se = SquaringEvent.new
  end

  describe 'relationships' do
    it { should belong_to(:group) }
    it { should have_many(:transactions) }
    it { should have_many(:user_squarings) }
    it { should have_many(:users).through(:user_squarings) }
  end

  describe '#group_balanced?' do
    it "returns true if the sum of all group member balances is 0" do
      @se.debtors = {:bar => -4}
      @se.creditors = {:foo => 5}
      expect(@se.group_balanced?).to eq(false)
    end

    it "returns false if the sum of all group member balances is NOT 0" do
      @se.debtors = {:bar => -5}
      @se.creditors = {:foo => 5}
      expect(@se.group_balanced?).to eq(true)
    end

  end

  describe '#bal_is_zero?' do
    it "returns an error if group's net balance is not 0" do
      @se.debtors = {:bar => -4}
      @se.creditors = {:foo => 5}
      expect{@se.bal_is_zero?}.to raise_error(ArgumentError)
    end

    it "returns true if all user balances are zero" do
      @se.debtors = {:bar => 0}
      @se.creditors = {:foo => 0}
      expect(@se.bal_is_zero?).to eq(true)
    end

    it "returns false if some user balances are not zero" do
      @se.debtors = {:bar => -5}
      @se.creditors = {:foo => 5}
      expect(@se.bal_is_zero?).to eq(false)
    end
  end

  describe '#ez_match' do

    describe 'when a payment match exists' do
      before do
        @se.debtors = {User.create => -5.0}
        @se.creditors = {User.create => 5.0}
      end
      it 'returns a hash' do
        expect(@se.ez_match).to be_an_instance_of(Hash)
      end

      it 'returns a hash with three items' do
        expect(@se.ez_match.length).to eq(3)
      end

      it 'returns a hash with users as the first value' do
        expect(@se.ez_match[:debtor]).to be_an_instance_of(User)
      end

      it 'returns a hash with users as the second value' do
        expect(@se.ez_match[:creditor]).to be_an_instance_of(User)
      end

      it 'returns a hash with user balances as the third value' do
        expect(@se.ez_match[:bal]).to be_an_instance_of(Float)
      end
    end
    describe 'when NO payment match exists' do
      before do
        @se.debtors = {User.create => -4.1, User.create => -1.2, User.create => 0}
        @se.creditors = {User.create => 5.3, User.create => 0}
      end
      it 'returns nil' do
        expect(@se.ez_match).to eq(nil)
      end
    end
  end

  describe '#high_low_match' do
    before do
      @se.debtors   = {User.create => -1.0,
                       User.create => -1.2,
                       User.create(first_name: "tanner") => -9.0,
                       User.create => -4.1}

      @se.creditors = {User.create => 5.3,
                       User.create(first_name: "steve") => 10.0}

    end

    it 'returns a hash' do
      expect(@se.high_low_match).to be_an_instance_of(Hash)
    end

    it 'returns a hash with three items' do
      expect(@se.high_low_match.length).to eq(3)
    end

    it 'returns a hash with users as the first value' do
      expect(@se.high_low_match[:debtor]).to be_an_instance_of(User)
    end

    it 'returns the correct debtor' do
      expect(@se.high_low_match[:debtor].first_name).to eq("tanner")
    end

    it 'returns a hash with users as the second value' do
      expect(@se.high_low_match[:creditor]).to be_an_instance_of(User)
    end

    it 'returns the correct creditor' do
      expect(@se.high_low_match[:creditor].first_name).to eq("steve")
    end

    it 'returns a hash with user balances as the third value' do
      expect(@se.high_low_match[:bal]).to be_an_instance_of(Float)
    end

    it 'returns the lowest absolute value of the two user balances' do
      expect(@se.high_low_match[:bal]).to eq(9)
    end
  end

  describe "#consolidated_transactions" do
    before do
      @debtors   = {User.create!(password:"1234") => -1.0,
                   User.create!(password:"1234") => -1.2,
                   User.create!(password:"1234") => -9.0,
                   User.create!(password:"1234") => -4.1,
                   User.create!(password:"1234") => -8.4,
                   User.create!(password:"1234") => -10.1}

      @creditors = {User.create!(password:"1234") => 5.3,
                   User.create!(password:"1234") => 10.0,
                   User.create!(password:"1234") => 5.1,
                   User.create!(password:"1234") => 1.0,
                   User.create!(password:"1234") => 2.1,
                   User.create!(password:"1234") => 0.3,
                   User.create!(password:"1234") => 10.0}
    end

    it "returns between 0 and n-1 transactions for a group of size n, which close out all debts" do
      expect(@se.consolidated_transactions(@debtors, @creditors).length).to eq(10)
    end
  end

  describe "#create_transaction" do
    let(:payment_match) { {debtor: User.create!(password:"1234"), creditor: User.create!(password:"1234"), bal:10.0} }

    it "adds an item to self.transactions" do
      @se.new_transactions = []
      @se.create_transaction(payment_match)

      expect(@se.new_transactions.size).to eq(1)
    end

    it "creates a new Transaction object" do
      @se.create_transaction(payment_match)
      expect(@se.new_transactions.last).to be_an_instance_of(Transaction)
    end

    it "does not save the transaction to the db" do
      starting = Transaction.all.size
      @se.create_transaction(payment_match)
      ending = Transaction.all.size

      expect(ending).to eq(starting)
    end
  end

end
