require 'rails_helper'

describe SquaringEvent do
  describe 'relationships' do
    it { should have_many(:transactions)}
    it { should have_many(:user_squarings)}
    it { should have_many(:users).through(:user_squarings)}
  end

  describe "#get_group_balance" do
  end

  describe


end
