class UserMailer < ActionMailer::Base
  default from: "mguehrs@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/signin'
    mail(to: @user.email, subject: 'Welcome to Le Cook Book app')
  end

  def forgot_password_email(user)
    @user = user
    @url  = 'http://localhost:3000/reset/'+user.remember_token
    mail(to: @user.email, subject: 'Reset your password')
  end

end