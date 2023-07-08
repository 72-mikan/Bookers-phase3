class GroupUsersController < ApplicationController
  def create
    if !GroupUser.exists?(group_id: params[:group_id], user_id: current_user.id)
      group_user = current_user.group_users.new(group_id: params[:group_id])
      group_user.save
      redirect_to groups_path
    end
  end

  def destroy
    if GroupUser.exists?(group_id: params[:group_id], user_id: current_user.id)
      group_user = current_user.group_users.find_by(group_id: params[:group_id])
      group_user.destroy
      redirect_to groups_path
    end
  end
end
