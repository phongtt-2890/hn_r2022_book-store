class Book < ApplicationRecord
  belongs_to :publisher
  delegate :name, to: :publisher, prefix: true, allow_nil: true
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  scope :newest, ->{order created_at: :desc}

  validates :quantity,
            numericality: {greater_than_or_equal_to: Settings.min_quantity,
                           less_than: Settings.max_quantity}
end
