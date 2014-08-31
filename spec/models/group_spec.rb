require 'rails_helper'
require_relative '../../app/models/group'
require 'pry'

describe Group do
	before do 
		@user1 = User.create(password:"1234")
		@user2 = User.create(password:"1234")
		@user3 = User.create(password:"1234")
		@user4 = User.create(password:"1234")


		@group1 = Group.create

		@membership1 = Membership.create(user: @user1, group: @group1)
		@membership2 = Membership.create(user: @user2, group: @group1)
		@membership3 = Membership.create(user: @user3, group: @group1)
		
		@transaction1 = Transaction.create(debtor: @user1, creditor:@user2, amount: 5.0, description: "qq", closed: false)
		@transaction2 = Transaction.create(debtor: @user1, creditor:@user4, amount: 5.0, description: "qq")
		@transaction3 = Transaction.create(debtor: @user2, creditor:@user3, amount: 5.0, description: "qq")
		@transaction4 = Transaction.create(debtor: @user2, creditor:@user4, amount: 5.0, description: "qq")
		@transaction5 = Transaction.create(debtor: @user3, creditor:@user1, amount: 5.0, description: "qq")

  	@square = SquaringEvent.create!
	end

  describe 'relationships' do
    it { should have_many(:squaring_events) }
    it { should have_many(:memberships) }
    it { should have_many(:users).through(:memberships) }
  end

  describe "#transactions" do 

  	it "only returns transactions between group members" do 
  		expect(@group1.transactions.size).to eq(3)
  	end

  	it "returns Transactions" do 
  		expect(@group1.transactions[0]).to be_an_instance_of(Transaction)
  	end

  	it "does not return private transactions" do
  		transaction6 = Transaction.create!(debtor: @user3, creditor:@user1, amount: 5.0, description: "qq", private_trans: true)
  		transaction7 = Transaction.create!(debtor: @user3, creditor:@user2, amount: 5.0, description: "qq", private_trans: false)
  		expect(@group1.transactions.size).to eq(4)
  	end

  	it "does not return closed transactions" do
  		transaction6 = Transaction.create!(debtor: @user3, creditor:@user1, amount: 5.0, description: "qq", closed: true)
  		transaction7 = Transaction.create!(debtor: @user3, creditor:@user2, amount: 5.0, description: "qq", closed: false)
  		expect(@group1.transactions.size).to eq(4)
  	end

  end

  # describe "#close_old_transactions" do 
		# @user1 = User.create(password:"1234")
		# @user2 = User.create(password:"1234")
		# @user3 = User.create(password:"1234")
		# @user4 = User.create(password:"1234")


		# @group1 = Group.create

		# @membership1 = Membership.create(user: @user1, group: @group1)
		# @membership2 = Membership.create(user: @user2, group: @group1)
		# @membership3 = Membership.create(user: @user3, group: @group1)
		
		# @transaction1 = Transaction.create(debtor: @user1, creditor:@user2, amount: 5.0, description: "qq", closed: false)
		# @transaction2 = Transaction.create(debtor: @user1, creditor:@user4, amount: 5.0, description: "qq")
		# @transaction3 = Transaction.create(debtor: @user2, creditor:@user3, amount: 5.0, description: "qq")
		# @transaction4 = Transaction.create(debtor: @user2, creditor:@user4, amount: 5.0, description: "qq")
		# @transaction5 = Transaction.create(debtor: @user3, creditor:@user1, amount: 5.0, description: "qq")

  # 	@square = SquaringEvent.create!
  # 	transactions = @group1.transactions

  # 	it "marks all old transactions as closed" do 

  # 	binding.pry
  # 		@group1.close_old_transactions(@square)
  # 		expect(transactions[0].closed).to eq(true)
  # 	end

  # 	it "marks all old transactions with squaring event id" do 
  # 		@group1.close_old_transactions(@square)
  # 		expect(@transaction1.squaring_event_id).to eq(@square.id)
  # 	end

  # end

end
