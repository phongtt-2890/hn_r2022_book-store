class CartsController < ApplicationController
  before_action :check_logged_in, only: %i(show)

  def show
    @order_details = current_order.order_details
  end
end
