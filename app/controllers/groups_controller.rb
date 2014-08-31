class GroupsController < ApplicationController
  def index
  end

  def create
    @group = Group.new
    @group.users << current_user
    @group.save

    redirect_to edit_user_group_path(@user.id, @group.id)

    # new_user_group_squaring_event_path(@user.id, @group.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @square = SquaringEvent.new
    @group_transactions = Transaction.where("debtor_id = ? OR creditor_id = ?", current_user.id, current_user.id).reverse_order
    @group = Group.find(params[:id])
  end

  def update

  end

end
