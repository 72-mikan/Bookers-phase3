class GroupMailsController < ApplicationController
  def new
    @group_mail = GroupMail.new
  end

  def create
    @group_mail = GroupMail.new(group_mail_params)
    @group = Group.find(params[:group_id])
    @group_mail.group_id = @group.id
    puts 'test1'
    if @group_mail.save!
      puts 'test2'
      @group.users.each do |user|
        puts 'test'
        GroupMailMailer.with(group_mail: @group_mail, user: user).event_mail.deliver_later
      end
      puts 'test3'
      redirect_to group_group_mail_complete_path(@group.id, @group_mail.id)
    else
      puts 'test4'
      render :new
    end
  end

  def complete
    @group_mail = GroupMail.find(params[:id])
  end

  private

  def group_mail_params
    params.require(:group_mail).permit(:title, :body)
  end
end
