class SessionsController < ApplicationController

	
	def new
	end

	def create
		@user = User.find_by(username: params[:username])
    if @user.authenticate(params[:password])
			session[:user_id] = @user.id
			render "new"
		else
  	redirect_to root_url			
		end
	end

	def destroy
		session[:user_id] = nil
  	redirect_to root_url
	end


end