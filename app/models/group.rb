class Group < ActiveRecord::Base
  has_many :squaring_events
  has_many :memberships
  has_many :users, :through => :memberships

  attr_reader :debtors, :creditors

  def square
  	square = SquaringEvent.create(group_id: self.id)
  	square.square(debtors, creditors)
  end

  def debtors
	  users = self.users
	  debtors = Hash.new
    users.each do |user|
    	balance = user.find_balance(users)
    	if balance < 0
    		debtors[user] = balance
  		end
		end
		return debtors
	end  	

  def creditors
	  users = self.users
    creditors = Hash.new
    users.each do |user|
    	balance = user.find_balance(users)
    	if balance > 0
    		creditors[user] = balance
    	end
    end
    return creditors
  end

  # def transactions
  # 	all_transactions = []
  # 	self.users.debits.where()
  # 	self.users.credits.where()
  # end

end