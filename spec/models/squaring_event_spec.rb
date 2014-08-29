require 'rails_helper'
require_relative '../../app/models/squaring_event'

describe SquaringEvent do
  before do
    @se = SquaringEvent.new
  end
  describe 'relationships' do
    it { should have_many(:transactions)}
    it { should have_many(:user_squarings)}
    it { should have_many(:users).through(:user_squarings)}
  end

  #Need to call each expect block with an instance of a SquaringEvent
  # describe "#get_group_balance" do
  #   it "returns a hash" do
  #     expect(get_group_balance).to be_an_instance_of(Hash)
  #   end

  #   it "has users as keys" do
  #     expect(get_group_balance.keys.first).to be_an_instance_of(User)
  #   end

  #   it "has values of type integer" do
  #     expect(get_group_balance.values.first).to be_an_instance_of(Float)
  #   end

  # end

  describe '#bal_is_zero?' do
    it "returns an error if group's net balance is not 0" do
      @se.group_bal_hash = {:fuck => 5, :you =>-4}
      expect{@se.bal_is_zero?}.to raise_error(ArgumentError)
    end

    it "returns true if all user balances are zero" do
      @se.group_bal_hash = {:fuck => 0, :you =>0}
      expect(@se.bal_is_zero?).to eq(true)
    end

    it "returns false if some user balances are not zero" do
      @se.group_bal_hash = {:fuck => 5, :you =>-5}
      expect(@se.bal_is_zero?).to eq(false)
    end
  end

  describe 'ez_match' do

    describe 'when a match exists' do
      before do
        @se.group_bal_hash = {User.new => 5.0, User.new => -5.0}
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
    describe 'when NO match exists' do
      before do
        @se.group_bal_hash = {User.new => 5.3, User.new => -1.2, User.new => -4.1}
      end
      it 'returns nil' do
        expect(@se.ez_match).to eq(nil)
      end
    end
  end

  describe


end
