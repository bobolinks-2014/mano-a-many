class SquaringEventController < ApplicationController

	#GET square up page
	#need some killer jquery action
	def new
		current_user
		@square = SquaringEvent.new
		@group_transactions = Transaction.where("debtor_id = ? OR creditor_id = ?", current_user.id, current_user.id).reverse_order
	end

	#on press of square up button: creates new square
	def create
		if false
				#insert logic
			redirect_to user_url(@user)
		else
			flash.notice = "Square up failed. Try again."
  		render 'new'
		end
	end

end
