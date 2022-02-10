class BooksController < ApplicationController
  before_action :load_book, :check_logged_in, only: %i(show)

  def show
    @order_detail = current_order.order_details.new
  end
end
