class SendingDestination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :post_code, :prefecture_code, :city, :house_number, :building_name, :phone_number, presence: true
end
