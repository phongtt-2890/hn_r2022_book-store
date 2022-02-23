class User < ApplicationRecord
  USER_ATTRS = %i(name email phone
                password password_confirmation remember_me).freeze

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.max_256_digest}
  validates :email, presence: true, uniqueness: {case_sensitive: true},
    format: {with: Settings.email_regex},
    length: {maximum: Settings.max_256_digest}
  validates :password, presence: true,
    length: {minimum: Settings.min_password_length}, if: :password
end
