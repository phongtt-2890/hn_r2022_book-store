class BooksController < ApplicationController
  before_action :authenticate_user!, :load_book, only: %i(show)

  def show
    @order_detail = current_order.order_details.new
  end
end
