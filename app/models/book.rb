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

  validates :name, presence: true
  validates :num_pages, presence: true,
            numericality: {greater_than_or_equal_to: Settings.min_quantity,
                           less_than: Settings.max_quantity}
  validates :price, presence: true,
            numericality: {greater_than_or_equal_to: Settings.min_quantity}
  validates :quantity, presence: true,
            numericality: {greater_than_or_equal_to: Settings.min_quantity,
                           less_than: Settings.max_quantity}

  accepts_nested_attributes_for :book_authors, reject_if: :all_blank,
                                allow_destroy: true
end
