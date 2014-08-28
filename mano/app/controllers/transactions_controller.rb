class TransactionsController < ApplicationController

	def index
	end

	def show
	end

	def new
		@transaction = Transaction.new
	end

	def create
		@friend_email = params[:transaction][:name]
		@friend = User.find_by(email: @friend_email)
		@transaction = Transaction.new
	end

end