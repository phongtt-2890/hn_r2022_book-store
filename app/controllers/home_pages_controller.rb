class HomePagesController < ApplicationController
  def home
    @pagy, @books = pagy Book.newest, items: Settings.books_per_page
  end

  def help; end
end
