class Like < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validate :own_item_cannot_like

  private

  def own_item_cannot_like
    return unless item && item.user_id == user_id

    errors.add(:user_id, 'You cannot like your own items')
  end
end
