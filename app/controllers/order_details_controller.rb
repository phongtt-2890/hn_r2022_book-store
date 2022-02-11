class OrderDetailsController < ApplicationController
  before_action :current_order, only: %i(create update destroy)
  before_action :load_order_details, only: %i(update destroy)
  before_action :exist_order_detail, only: %i(create)

  def create
    @order_detail = @current_order.order_details.new order_detail_params
    if @current_order.save
      flash.now[:success] = t "success"
    else
      flash.now[:danger] = t "delete_fail"
    end
  end

  def update
    if @order_detail.update order_detail_params
      @order_details = @current_order.order_details
      @current_order.save
      flash.now[:success] = t "success"
    else
      flash.now[:danger] = t "update_fail"
    end
  end

  def destroy
    if @order_detail.destroy
      @order_details = @current_order.order_details
      @current_order.save
      flash.now[:success] = t "success"
    else
      flash.now[:danger] = t "delete_fail"
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:book_id,
                                         :order_quantity, :price_at_order)
  end

  def load_order_details
    @order_detail = @current_order.order_details.find_by id: params[:id]
    return if @order_detail

    flash[:danger] = t "order_detail_not_found"
    redirect_to root_path
  end

  def exist_order_detail
    exist_order = @current_order.order_details.find_by book_id:
                                              order_detail_params[:book_id],
                                              order_id: current_order.id
    return unless exist_order

    flash[:danger] = t "already_in_cart"
    redirect_to carts_path
  end
end
