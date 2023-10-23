class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[!-~]+\z/
  NAME_MAXIMUM_LIMIT = 20
  PASSWORD_MINIMUM_LIMIT = 8
  PASSWORD_MAXIMUM_LIMIT = 128

  has_many :spots

  attr_accessor :skip_password_validation # パスワードバリデーションをスキップするためのフラグ

  before_save { self.email = self.email.downcase }

  validates :name, presence: true, length: { maximum: NAME_MAXIMUM_LIMIT }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: :invalid_email_format }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX, message: :invalid_password_format }, confirmation: true, length: { minimum: 8, maximum: 128 }, unless: :skip_password_validation
  validates :password_confirmation, presence: true, if: :password_required?

  before_validation :skip_password_validation, on: :update #更新時のみバリデーション

  after_initialize do
    self.skip_password_validation = false
  end

  def skip_password_validation
    self.skip_password_validation = true
  end

  scope :valid, -> { where(is_deleted: false) }
end
