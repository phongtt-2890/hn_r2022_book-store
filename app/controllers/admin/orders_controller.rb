class Admin::OrdersController < Admin::AdminController
  before_action :load_newest_order, only: %i(index destroy update)
  load_and_authorize_resource

  def index; end

  def update
    ActiveRecord::Base.transaction do
      @order.public_send("status_#{params[:status]}!")
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "update_fail"
    redirect_to admin_orders_path
  end

  def destroy
    update_book_quantity_for_order_delete @order unless @order.status_accepted?

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

  def load_newest_order
    @pagy, @orders = pagy Order.without_init_status.newest,
                          items: Settings.orders_per_page
  end
end
