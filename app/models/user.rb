class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\z/
  NAME_MAXIMUM_LIMIT = 10
  PASSWORD_MINIMUM_LIMIT = 8
  PASSWORD_MAXIMUM_LIMIT = 128

  has_many :spots

  attr_accessor :skip_password_validation # パスワードバリデーションをスキップするためのフラグ

  before_save { self.email = self.email.downcase }

  validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LIMIT }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: :invalid_email_format }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 8, maximum: 128 }, format: { with: VALID_PASSWORD_REGEX, message: :invalid_password_format }, unless: :skip_password_validation

  before_validation :skip_password_validation, on: :update #更新時のみバリデーション

  def skip_password_validation
    self.skip_password_validation = true
  end

  scope :valid, -> { where(is_deleted: false) }
end
