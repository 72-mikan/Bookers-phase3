class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # 前日比
    # @post_today = @user.post_counts.where(created_at: Time.zone.now.all_day).count
    @post_today = @user.post_counts.where("created_at >= ?", Time.zone.now.beginning_of_day).count
    # @post_yesterday = @user.post_counts.where(created_at: 1.day.ago.all_day).count
    @post_yesterday = @user.post_counts.where("created_at >= ? and created_at <= ?", 1.day.ago.beginning_of_day, Time.zone.now.beginning_of_day).count
    # 前週比(day_before呼び出し)
    @day_before = day_before(@post_today, @post_yesterday)
    @this_week = @user.post_counts.where("created_at >= ?", 1.week.ago.beginning_of_day).count
    @last_week = @user.post_counts.where("created_at >= ? and created_at <= ?", 2.week.ago.beginning_of_day, 1.week.ago.beginning_of_day).count
    # 先週比(comp_last_week呼び出し)
    @comp_last_week = comp_last_week(@this_week, @last_week)
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  # 前日比
  def day_before(post_today, post_yesterday)
    if post_today == 0
      day_before = 0
    elsif post_yesterday == 0
      day_before = post_today * 100
    else
      day_before = ((post_today.to_f / post_yesterday.to_f) * 100).round
    end
    return day_before
  end

  # 先週比
  def comp_last_week(this_week, last_week)
    if this_week == 0
      comp_last_week = 0
    elsif last_week == 0
      comp_last_week = this_week * 100
    else
      comp_last_week = ((this_week.to_f / last_week.to_f) * 100).round
    end
    return comp_last_week
  end
end
