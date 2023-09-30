class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{8,128}\z/
  NAME_MAXIMUM_LIMIT = 10
  PASSWORD_MINIMUM_LIMIT = 8
  PASSWORD_MAXIMUM_LIMIT = 128
  before_save { self.email = self.email.downcase }

  validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LIMIT }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8, maximum: 128 }, format: { with: VALID_PASSWORD_REGEX }, unless: :skip_password_validation
  attr_accessor :skip_password_validation # パスワードバリデーションをスキップするためのフラグ
  before_validation :skip_password_validation, on: :update #更新時のみバリデーション

  def skip_password_validation
    self.skip_password_validation = true
  end

  scope :valid, -> { where(is_deleted: false) }
end
