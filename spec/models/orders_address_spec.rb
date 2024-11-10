require 'rails_helper'

RSpec.describe OrdersAddress, type: :model do
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    @orders_address = FactoryBot.build(:orders_address, item_id: item.id, user_id: user.id)
    sleep(0.1)
  end
  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@orders_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @orders_address.building_name = ''
        expect(@orders_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @orders_address.post_code = ''
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("Post code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @orders_address.post_code = '1234567'
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it 'prefectureを選択していないと保存できないこと' do
        @orders_address.prefecture_id = '1'
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @orders_address.city = ''
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @orders_address.address = ''
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @orders_address.phone_number = ''
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが10桁以上11桁以内でないと保存できないこと' do
        @orders_address.phone_number = '123'
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include('Phone number is invalid.Please enter 10-11 digit half-width numbers')
      end
      it 'phone_numberが半角数字でないと保存できないこと' do
        @orders_address.phone_number = '０９０１２３４５６７８'
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include('Phone number is invalid.Please enter 10-11 digit half-width numbers')
      end
      it 'userが紐付いていないと保存できないこと' do
        @orders_address.user_id = nil
        @orders_address.valid?
        expect(@orders_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @orders_address.item_id = nil
        @orders_address.valid?
        binding.pry
        expect(@orders_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
