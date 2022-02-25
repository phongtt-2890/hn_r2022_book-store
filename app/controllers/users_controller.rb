class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def show; end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password, :password_confirmation)
  end
end
