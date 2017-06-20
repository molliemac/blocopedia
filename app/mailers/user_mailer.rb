class UserMailer < ActionMailer::Base
  default from: "mollie.mcintyre9@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Blocipedia!")
  end
end