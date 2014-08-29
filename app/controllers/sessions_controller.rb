class SessionsController < ApplicationController
  include UsersHelper
	
	#GET - login page
	def new
	end

	#on press of login button: creates new session
	def create
		@user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
			session[:user_id] = @user.id
			redirect_to user_url(@user)
		else
			flash.notice = "Login failed. Try again."
  		redirect_to root_url
		end
	end


	#on press of logout button
	def destroy
		session[:user_id] = nil
  	redirect_to root_url
	end

end
