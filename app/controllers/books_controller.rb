class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i(show)
  load_and_authorize_resource

  def show
    @order_detail = current_order.order_details.new
  end
end
