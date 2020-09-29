class Item < ApplicationRecord

  
  validates :name, :introduction, :category_id, :item_condition_id, :postage_payer_id, :prefecture_code_id, :preparation_day_id, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :images, length: { in: 1..5 }
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :itemcondition
  belongs_to_active_hash :postage
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation

  has_many :images, dependent: :destroy
  belongs_to :seller, class_name: 'User'
  belongs_to :buyer, class_name: 'User'
  belongs_to :category

  accepts_nested_attributes_for :images, allow_destroy: true

end
