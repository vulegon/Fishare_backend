class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: "メールアドレス認証のお願い")
  end
end
