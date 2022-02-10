class Admin::AdminController < ApplicationController
  before_action :check_logged_in, :require_admin

  def require_admin
    return if current_user.admin?

    redirect_to root_path
  end
end
