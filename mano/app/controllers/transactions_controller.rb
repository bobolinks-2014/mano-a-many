class TransactionsController < ApplicationController
	include TransactionsHelper

	def index
	end

	def show
	end

	def new
		@transaction = Transaction.new
	end

	def create
		@friend = find_friend
		if current_user_is_borrower?
			@transaction = Transaction.new(debtor: current_user, creditor: @friend, amount: transaction_params[:amount], description: transaction_params[:description], private_trans: private_transaction?, approved: false)
		else
			@transaction = Transaction.new(debtor: @friend, creditor: current_user, amount: transaction_params[:amount], description: transaction_params[:description], private_trans: private_transaction?, approved: false)			
		end
		if @transaction.save
			redirect_to user_path(current_user)
		else
			flash.notice = "Transaction not created. Try again."
			render :new
		end
	end

private

	def find_friend
	  User.find_by(email: transaction_params[:friend_email])
	end

	def private_transaction?
		transaction_params[:private_trans] == "1"
	end

	def current_user_is_borrower?
		transaction_params[:borrower]
	end

end