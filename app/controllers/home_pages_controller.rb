class HomePagesController < ApplicationController
  def home
    @search = Book.ransack params[:q]
    @pagy, @books = pagy @search.result, items: Settings.books_per_page
  end

  def help; end
end
