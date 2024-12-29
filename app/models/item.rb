class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  has_many :likes
  has_one_attached :image

  belongs_to :category
  belongs_to :situation
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :time_required

  validates :image, presence: true
  validates :item_name, presence: true
  validates :explanation, presence: true
  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :situation_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :time_required_id, numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                                    message: 'Please register between 300 yen and 9,999,999 yen' }
  validates :price, presence: true, numericality: { only_integer: true, message: 'Half-width (digits) required' }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
