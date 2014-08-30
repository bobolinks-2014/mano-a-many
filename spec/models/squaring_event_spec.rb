require 'rails_helper'
require_relative '../../app/models/squaring_event'

describe SquaringEvent do  
  before do
    @se = SquaringEvent.new
  end

  describe 'relationships' do
    it { should belong_to(:group) }
    it { should have_many(:transactions) }
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
        @se.debtors = {User.new => -5.0}
        @se.creditors = {User.new => 5.0}
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
        @se.debtors = {User.new => -4.1, User.new => -1.2, User.new => 0}
        @se.creditors = {User.new => 5.3, User.new => 0}
      end
      it 'returns nil' do
        expect(@se.ez_match).to eq(nil)
      end
    end
  end

  describe '#high_low_match' do
    before do
      @se.debtors   = {User.new => -1.0,
                       User.new => -1.2,
                       User.new(first_name: "tanner") => -9.0,
                       User.new => -4.1}

      @se.creditors = {User.new => 5.3, 
                       User.new(first_name: "steve") => 10.0}
                            
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

  describe "#square" do 
    before do
      @debtors   = {User.new => -1.0,
                   User.new => -1.2,
                   User.new => -9.0,
                   User.new => -4.1,
                   User.new => -8.4,
                   User.new => -10.1}

      @creditors = {User.new => 5.3, 
                   User.new => 10.0,
                   User.new => 5.1,
                   User.new => 1.0,
                   User.new => 2.1,
                   User.new => 0.3,
                   User.new => 10.0}
    end

    it "returns between 0 and n-1 transactions for a group of size n, which close out all debts" do 
      expect(@se.square(@debtors, @creditors).length).to eq(10)
    end
  end

#############################################
######### NOT SURE HOW TO TEST THIS #########
#############################################

  pending "#create_transaction" do
    let(:payment_match) { {debtor: User.new, creditor: User.new, bal:10.0} }

    it "adds an item to self.transactions" do
      expect {@se.create_transaction(payment_match)}.to change(@se.transactions).by(1)
    end

    it "creates a new Transaction object" do
      @se.create_transaction(payment_match)
      expect(@se.transactions.last).to be_an_instance_of(Transaction)
    end
  end

####################################################
######### NOT SURE HOW TO TEST THIS EITHER #########
####################################################

  pending "#update_group_hash" do
    let(:payment_match) { {debtor: User.new, creditor: User.new, bal:10.0} }

    it "updates the values of self.group_bal_hash, given a payment_match " do
      ###
    end
  end
end
