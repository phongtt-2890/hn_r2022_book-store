class CartsController < ApplicationController
  before_action :check_logged_in, only: %i(show)
  before_action :load_current_order, :load_order_details, only: %i(show update)

  def index
    @pagy, @orders = pagy current_user.orders.newest,
                          items: Settings.orders_per_page
  end

  def show; end

  def update
    ActiveRecord::Base.transaction do
      @current_order.update! status: params.dig(:order, :status).to_i,
                             delivery_address: params[:delivery_address]
      @order_details.find_each do |od|
        od.book.update! quantity: od.book.quantity - od.order_quantity
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t "update_fail"
    render :show
  end

  private

  def load_current_order
    @current_order = current_order
  end

  def load_order_details
    @order_details = current_order.order_details
  end
end
