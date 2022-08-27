class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("text.activation_subj")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("text.reset_password")
  end
end
