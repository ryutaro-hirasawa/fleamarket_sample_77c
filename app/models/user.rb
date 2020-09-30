class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 正規表現を変数に変換
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_KANA_REGEX = /\A[ぁ-ん]+\z/

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7 }
  validates :nickname,:first_name,:family_name,:birth_day, presence: true
  validates :first_name_kana,:family_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  has_one :sending_destination
  has_one :card, dependent: :destroy
end
