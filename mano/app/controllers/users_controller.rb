class UsersController < ApplicationController

	#GET - login page
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
	  	render 'new'
	  end
	end



end