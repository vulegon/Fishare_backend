class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  NAME_MAXIMUM_LIMIT = 20
  PASSWORD_MINIMUM_LIMIT = 8
  PASSWORD_MAXIMUM_LIMIT = 128

  validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LIMIT }
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8, maximum: 128 }, format: { with: VALID_PASSWORD_REGEX }

  scope :valid, -> { where(is_deleted: false) }
end
