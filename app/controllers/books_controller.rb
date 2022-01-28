class BooksController < ApplicationController
  before_action :load_book, only: %i(show)

  def show; end
end
