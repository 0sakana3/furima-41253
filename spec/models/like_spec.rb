require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'いいね機能' do
    context 'いいねができる場合' do
      it 'user_idとitem_idがあれば保存できる' do
        expect(@like).to be_valid
      end
      it 'item_idが同じでもuser_idが違えばいいねできる' do
      end
      it 'user_idが同じでもitem_idが違えばいいねできる' do
      end
    end
    context 'いいねができない場合' do
      it 'user_idが空ではいいねできない' do
      end
      it 'item_idが空ではいいねできない' do
      end
    end
  end
end
