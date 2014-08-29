require 'rails_helper'

describe User do
  describe 'association tests' do
    it { should have_many(:debits).class_name('Transaction').with_foreign_key('creditor_id') }
    it { should have_many(:credits).class_name('Transaction').with_foreign_key('debtor_id') }
    it { should have_many(:user_squarings) }
    # it { should have_many(:squaring_events), through: 'user_squarings' }
  end

  describe "sum_debits and credits" do
    before do
      @user = User.create!(first_name: "fname1",
                            last_name: "lname1",
                            email: "at@at.com",
                            password: "12341234")
      @user2 = User.create!(first_name: "fname2",
                            last_name: "lname2",
                            email: "at2@at.com",
                            password: "12341234")
      @transaction1 = Transaction.create!(debtor_id: @user.id,
                                         creditor_id: @user2.id,
                                         amount: 9,
                                         description: Faker::Hacker.say_something_smart,
                                         approved: true,
                                         closed: false,
                                         squaring_event_id: nil,
                                         private_trans: false)
      @transaction2 = Transaction.create!(debtor_id: @user2.id,
                                         creditor_id: @user.id,
                                         amount: 10,
                                         description: Faker::Hacker.say_something_smart,
                                         approved: true,
                                         closed: false,
                                         squaring_event_id: nil,
                                         private_trans: false)
    end
    it "should return total of debits for a user" do
      expect(@user.sum_debits).to eq(10)
    end
     it "should return a total of credits for a user" do
      expect(@user.sum_credits).to eq(9)
    end
  end

  describe "find_balance" do
    before do
      @user1 = User.create!(first_name: "fname1",
                            last_name: "lname1",
                            email: "at@at.com",
                            password: "12341234"
                            )
      @user2 = User.create!(first_name: "fname2",
                            last_name: "lname2",
                            email: "at2@at.com",
                            password: "12341234"
                            )
      @transaction = Transaction.create!(debtor_id: @user1.id,
                                         creditor_id: @user2.id,
                                         amount: 10,
                                         description: Faker::Hacker.say_something_smart,
                                         approved: true,
                                         closed: false,
                                         squaring_event_id: nil,
                                         private_trans: false
                                         )
    end

    it "should return a negative balance for a user" do
      expect(@user1.find_balance).to eq(-10)
    end

    it "should return a positive balance for a user" do
      expect(@user2.find_balance).to eq(10)
    end
  end
end
