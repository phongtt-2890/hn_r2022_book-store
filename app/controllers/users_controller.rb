class UsersController < ApplicationController
  before_action :load_user, except: %i(new create)

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "create_user_success"
      redirect_to @user
    else
      flash.now[:danger] = t "create_user_fail"
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
                                 :password, :password_confirmation)
  end
end
