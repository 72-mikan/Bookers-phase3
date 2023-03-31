class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.save
    @group.group_users.create(user_id: current_user.id)
    redirect_to groups_path
  end

  def index
    @book = Book.new
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
    @group.update(group_params)
    redirect_to group_path(@group.id)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    @user = @group.owner_id
    unless @user == current_user.id
      redirect_to groups_path
    end
  end
end
