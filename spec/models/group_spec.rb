require 'rails_helper'
require_relative '../../app/models/group'

describe Group do
  describe 'relationships' do
    it { should have_many(:squaring_events) }
    it { should have_many(:memberships) }
    it { should have_many(:users).through(:memberships) }
  end

  describe 'creditors and debtors' do
    before do
      @group = Group.create!
      @user1 = User.create!(first_name: "fname1",
                          last_name: "lname1",
                          email: "at1@at.com",
                          password: "12341234")
      @user2 = User.create!(first_name: "fname2",
                          last_name: "lname2",
                          email: "at2@at.com",
                          password: "12341234")
      membership1 = Membership.create!(user: @user1, group_id: @group.id)
      membership2 = Membership.create!(user: @user2, group_id: @group.id)
      transaction1 = Transaction.create!(debtor_id: @user1.id, creditor_id: @user2.id, amount: 10, description: "Blah")
    end
    it "should return creditors of a group" do
      expect(@group.creditors.length).to eq(1)
    end
    it "should return debtors of a group" do
      expect(@group.debtors.length).to eq(1)
    end
    it "should return transaction if not square" do
      expect(@group.square.length).to eq(1)
    end
  end
end
