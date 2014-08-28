class SessionsController < ApplicationController
	
	#GET - login page
	def new
	end

	#on press of login button
	def create
		@user = User.find_by(email: params[:user][:email])
  	if @user.nil?
  		redirect_to root_url			  		
    elsif @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_url(@user)
		else
  		redirect_to root_url			
		end
	end


	#on press of logout button
	def destroy
		session[:user_id] = nil
  	redirect_to root_url
	end

end