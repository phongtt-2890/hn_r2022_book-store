class Discount < ApplicationRecord
  has_many :user_discounts, dependent: :destroy
  has_many :users, through: :user_discounts
end
