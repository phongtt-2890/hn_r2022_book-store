class CartsController < ApplicationController
  before_action :check_logged_in, only: %i(show)
  before_action :load_current_order, :load_order_details, only: %i(show update)
  before_action :load_order, only: %i(destroy)
  before_action :load_newest_order, only: %i(index destroy)

  def index; end

  def show; end

  def update
    ActiveRecord::Base.transaction do
      update_order
      update_book_quantity_for_order_delivery
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:danger] = t "update_fail"
    render :show
  end

  def destroy
    if @order.status != Settings.status_accepted
      @order.order_details.find_each do |od|
        od.book.update! quantity: od.book.quantity + od.order_quantity
      end
    end
    if @order.destroy
      flash[:success] = t "success"
      respond_to do |format|
        format.js
      end
    else
      flash.now[:danger] = t "delete_fail"
    end
  end

  private

  def load_current_order
    @current_order = current_order
  end

  def load_order_details
    @order_details = current_order.order_details
  end

  def update_order
    @current_order.update! status: params.dig(:order, :status).to_i,
                             delivery_address: params[:delivery_address]
  end

  def update_book_quantity_for_order_delivery
    @order_details.find_each do |od|
      od.book.update! quantity: od.book.quantity - od.order_quantity
    end
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "order_not_found"
    redirect_to root_path
  end

  def load_newest_order
    @pagy, @orders = pagy current_user.orders.newest,
                          items: Settings.orders_per_page
    return if @orders

    flash[:danger] = t "order_not_found"
    redirect_to root_path
  end
end
