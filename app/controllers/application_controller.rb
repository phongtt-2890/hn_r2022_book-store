class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  before_action :set_locale

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "user_not_found"
    redirect_to root_path
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book

    flash[:danger] = t "book_not_found"
    redirect_to root_path
  end

  def check_logged_in
    return if logged_in?

    flash[:danger] = t "must_login"
    redirect_to login_path
  end

  def current_user_admin?
    return false unless current_user.admin?

    redirect_to admin_root_path
  end
end
