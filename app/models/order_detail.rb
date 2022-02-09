class OrderDetail < ApplicationRecord
  belongs_to :book
  belongs_to :order

  before_save :set_unit_price, :set_total_price

  private

  def book_price
    if persisted?
      book.price
    else
      self[:price_at_order]
    end
  end

  def total
    price_at_order * order_quantity
  end

  def set_unit_price
    self[:price_at_order] = book_price
  end

  def set_total_price
    self[:total_price] = order_quantity * self[:price_at_order]
  end
end
