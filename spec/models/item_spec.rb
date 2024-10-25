require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品機能' do
    context '商品の出品ができる時' do
      it '必要な情報を適切に入力して「出品する」ボタンを押すと、商品の出品ができる' do
        expect(@item).to be_valid
      end
    end
    context '商品の出品ができない時' do
      it '画像が付いていないと商品の出品ができない' do
       @item.image = nil
       @item.valid?
       expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では商品の出品ができない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が空では商品の出品ができない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'カテゴリーが初期値では商品の出品ができない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態が初期値では商品の出品ができない' do
        @item.situation_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Situation can't be blank")
      end
      it '配送料の負担が初期値では商品の出品ができない' do
        @item.shipping_fee_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
      end
      it '発送元の地域が初期値では商品の出品ができない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日時が初期値では商品の出品ができない' do
        @item.time_required_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Time required can't be blank")
      end
      it '価格が空では商品の出品ができない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が全角では出品ができない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width (digits) required")
      end
      it '価格が半角英字では出品ができない' do
        @item.price = 'aaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width (digits) required")
      end
      it '価格が記号では出品ができない' do
        @item.price = '**'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Half-width (digits) required")
      end
      it '価格が300未満の場合には出品できない' do
        @item.price = '30'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Please register between 300 yen and 9,999,999 yen")
      end
      it '価格が10000000以上の場合には出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Please register between 300 yen and 9,999,999 yen")
      end
    end
  end
end
