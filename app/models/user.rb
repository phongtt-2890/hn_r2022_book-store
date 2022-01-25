class User < ApplicationRecord
  has_many :user_discounts, dependent: :destroy
  has_many :discounts, through: :user_discounts
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
end
