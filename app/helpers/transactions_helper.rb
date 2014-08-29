module TransactionsHelper

	def transaction_params
	  params.require(:transaction).permit(:friend_email, :amount, :description, :borrower, :private_trans)
	end

end