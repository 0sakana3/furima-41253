class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  # belongs_to :situation
  # belongs_to :shipping_fee
  # belongs_to :prefecture
  # belongs_to :time_required

  validates :item_name, :string, presence: true
  validates :explanation, :text, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :situation_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :time_required_id, numericality: { other_than: 1, message: "can't be blank" }
  # validates :price, :integer, presence: true
  # validates :user, :references, presence: true
end
