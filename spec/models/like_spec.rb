require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @like = FactoryBot.build(:like, user_id: user.id, item_id: item.id)
    sleep(0.1)
  end
  describe 'いいね機能' do
    context 'いいねができる場合' do
      it 'user_idとitem_idがあれば保存できる' do
        expect(@like).to be_valid
      end
      it 'item_idが同じでもuser_idが違えばいいねできる' do
        another_like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, user_id: another_like.user_id)).to be_valid
      end
      it 'user_idが同じでもitem_idが違えばいいねできる' do
        another_like = FactoryBot.create(:like)
        expect(FactoryBot.create(:like, item_id: another_like.item_id)).to be_valid
      end
    end
    context 'いいねができない場合' do
      it 'user_idが空ではいいねできない' do
        @like.user_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('User must exist')
      end
      it 'item_idが空ではいいねできない' do
        @like.item_id = nil
        @like.valid?
        expect(@like.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
