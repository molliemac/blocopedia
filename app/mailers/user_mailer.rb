class UserMailer < ActionMailer::Base
  default from: "mollie.mcintyre9@gmail.com"

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Blocipedia!")
  end
end