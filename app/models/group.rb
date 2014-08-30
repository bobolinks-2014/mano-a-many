require 'pry'
class Group < ActiveRecord::Base
  has_many :squaring_events
  has_many :memberships
  has_many :users, :through => :memberships

  attr_reader :debtors, :creditors

  def square
  	square = SquaringEvent.create(group_id: self.id)
  	square.square(debtors, creditors)
  	close_old_transactions(square)
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

  def transactions
  	all_transactions = []
  	user_ids = self.users.map {|user| user.id}

  	self.users.each do |user|
  		all_transactions << user.debits.where(debtor_id: user_ids)
  	end
  	all_transactions.flatten!
  	
  	all_transactions.delete_if do |transaction| 
  		transaction.private_trans == true || transaction.closed == true 
  	end
  end

  # def close_old_transactions(square)
  # 	transactions.each do |transaction|
  # 		transaction.update(squaring_event_id: square.id, closed: true)
	 #  	# binding.pry
  # 	end
  # end
end
