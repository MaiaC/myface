class WelcomeMailer < ApplicationMailer
  default from: 'welcome@myface.com'
  
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to MyFace")
  end
end
