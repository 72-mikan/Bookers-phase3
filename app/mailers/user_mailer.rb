class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def event_mail
    @user = params[:user]
    @content = params[:content]
    @group = params[:group]
    mail(to: @user.email, subject: @group + '通知')
  end
end
