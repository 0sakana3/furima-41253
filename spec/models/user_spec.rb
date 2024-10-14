require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context 'ユーザー登録ができる時' do
      it '必要な情報を適切に入力して「会員登録」ボタンを押すと、ユーザーの新規登録ができる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録ができない時' do
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが必要であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、＠を含む必要があること' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、６文字以上での入力が必須であること' do
        @user.password = '1234b'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      context 'パスワードは、半角英数混合での入力が必須であること' do
        it 'パスワードは、半角英字のみでないこと' do
          @user.password = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
        end
        it 'パスワードは、半角数字のみでないこと' do
          @user.password = '000000'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
        end
        it 'パスワードは、半角での入力が必須であること' do
          @user.password = 'ああああああ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
        end
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456a'
        @user.password_confirmation = '00000b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end

  describe '新規登録/本人情報確認' do
    context 'お名前（全角）は、名字と名前がそれぞれ必須であること' do
      it '名字の入力が必須であること' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '名前の入力が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
    end
    context 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      it '名字(全角)は、半角でないこと' do
        @user.family_name = 'the'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name Full-width (Kanji, Hiragana, Katakana) required')
      end
      it '名前(全角)は、半角でないこと' do
        @user.family_name = 'boss'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name Full-width (Kanji, Hiragana, Katakana) required')
      end
    end
    context 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      it '名字(カナ)の入力が、必須であること' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it '名前(カナ)の入力が、必須であること' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
    end
    context 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      it '名字(カナ)の入力は、半角でないこと' do
        @user.family_name_kana = 'the'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '名字(カナ)の入力は、全角（ひらがな）でないこと' do
        @user.family_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '名字(カナ)の入力は、全角（漢字）でないこと' do
        @user.family_name_kana = '仮'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '名前(カナ)の入力は、半角でないこと' do
        @user.first_name_kana = 'boss'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '名前(カナ)の入力は、全角（ひらがな）でないこと' do
        @user.first_name_kana = 'えお'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '名前(カナ)の入力は、全角（漢字）でないこと' do
        @user.first_name_kana = '名無'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
    end
    it '生年月日が必須であること' do
      @user.date_of_birth = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Date of birth can't be blank")
    end
  end
end
