class GroupMailMailer < ApplicationMailer
  default from: 'testgmail.com'

  def event_mail
    @user = params[:user]
    @group_mail = params[:group_mail]
    mail(to: @user.email, subject: @group_mail.title)
  end
end
