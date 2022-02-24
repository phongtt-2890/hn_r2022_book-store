class UsersController < ApplicationController
  before_action :authenticate_user!, :load_user, only: %i(show)

  def show; end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password, :password_confirmation)
  end
end
