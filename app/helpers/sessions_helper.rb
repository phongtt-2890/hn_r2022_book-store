module SessionsHelper
  def current_order
    @current_order = find_init_order || new_order
  end

  def new_order
    current_user.orders.build
  end

  def find_init_order
    current_user.orders.status_init.first
  end
end
