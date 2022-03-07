class Book < ApplicationRecord
  belongs_to :publisher
  delegate :name, to: :publisher, prefix: true, allow_nil: true
  belongs_to :category
  has_one_attached :image
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

  validates :image, content_type: {in: Settings.image_type},
            size: {less_than: Settings.max_image_size.megabytes}

  accepts_nested_attributes_for :book_authors, reject_if: :all_blank,
                                allow_destroy: true

  ransack_alias :book, :name_or_description_or_publisher_name
  ransacker :created_at do
    Arel.sql("date(created_at)")
  end
end
