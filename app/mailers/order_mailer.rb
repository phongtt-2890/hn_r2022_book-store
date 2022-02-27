class OrderMailer < ApplicationMailer
  def order_accepted user
    @user = user

    mail to: user.email, subject: @greeting
  end

  def order_rejected user
    @user = user

    mail to: user.email, subject: @greeting
  end
end
