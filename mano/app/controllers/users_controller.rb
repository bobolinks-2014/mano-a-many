class UsersController < ApplicationController
	include UsersHelper

	def index 
	end

#GET - render registration page
	def new 
		@user = User.new
	end

#POST - create new user via registration page
	def create 
		@user = User.new(user_params)
	  if @user.save
	  	redirect_to root_path
	  else
	  	flash.notice = "User Registration failed. Try again."
	  	render 'new'
	  end
	end

	def show
		current_user
		@debtor_trans = Transaction.where(debtor_id: current_user.id)
		@creditor_trans = Transaction.where(creditor_id: current_user.id)
	end



end