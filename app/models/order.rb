class Order < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item
  belongs_to :user
  has_one :address

  belongs_to :prefecture
end
