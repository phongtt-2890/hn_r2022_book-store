class UserMailer < ApplicationMailer
  def order_accepted user
    @user = user

    mail to: user.email, subject: t("order_accepted")
  end

  def order_rejected user
    @user = user

    mail to: user.email, subject: t("order_rejected")
  end
end
