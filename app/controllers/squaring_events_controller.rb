require 'pry'
class SquaringEventsController < ApplicationController

	def index
		redirect_to new_user_group_squaring_event_path
	end
	#GET square up page
	#need some killer jquery action
	def new
		# current_user
		@user = User.find(params[:user_id])
		@square = SquaringEvent.new
		@group = Group.find(params[:group_id])
		@group_transactions = @group.preview_new_transactions
	end

	#on press of square up button: creates new square
	def create
		@group = Group.find(params[:group_id])
		@group.save_transactions

		redirect_to user_path(params[:user_id])
	end



end
