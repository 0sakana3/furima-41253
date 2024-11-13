class OrdersAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :post_code, :prefecture_id, :city, :address, :building_name,
                :phone_number, :token

  VALID_POST_CODE_REGEX = /\A\d{3}-\d{4}\z/
  VALID_PHONE_NUMBER = /\A\d{10,11}\z/
  with_options presence: true do
    validates :post_code, format: { with: VALID_POST_CODE_REGEX, message: 'is invalid. Include hyphen(-)' }
    validates :city
    validates :address
    validates :phone_number,
              format: { with: VALID_PHONE_NUMBER, message: 'is invalid.Please enter 10-11 digit half-width numbers' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(item_id:, user_id:)
    Address.create(post_code:, prefecture_id:, city:, address:, building_name:, phone_number:, order_id: order.id)
  end
end
