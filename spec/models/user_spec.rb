require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do
    context 'ユーザー登録ができる時' do
      it '必要な情報を適切に入力して「会員登録」ボタンを押すと、ユーザーの新規登録ができること' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録ができない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したメールアドレスは登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字未満では登録できない' do
        @user.password = '1234b'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Must contain both half-width alphanumeric characters')
      end
      it 'パスワードとパスワード（確認用）が不一致だと登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '00000b'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end
  end
  describe '新規登録/本人情報確認' do
    context 'ユーザー登録ができる時' do
      it '必要な情報を適切に入力して「会員登録」ボタンを押すと、ユーザーの新規登録ができること' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録ができない時' do
      it '姓（全角）が空だと登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end
      it '名（全角）が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.family_name = 'the'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name Full-width (Kanji, Hiragana, Katakana) required')
      end
      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.family_name = 'boss'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name Full-width (Kanji, Hiragana, Katakana) required')
      end
      it '姓（カナ）が空だと登録できない' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end
      it '名（カナ）が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '姓（カナ）の入力は、英数字だと登録出来ない' do
        @user.family_name_kana = 'the1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '姓（カナ）の入力は、全角（平仮名）だと登録出来ない' do
        @user.family_name_kana = 'あいう'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '姓（カナ）の入力は、全角（漢字）だと登録出来ない' do
        @user.family_name_kana = '仮'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '姓（カナ）の入力は、記号だと登録出来ない' do
        @user.family_name_kana = '**'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana Full-width (Katakana) required')
      end
      it '名（カナ）の入力は、半角だと登録出来ない' do
        @user.first_name_kana = 'boss0'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '名（カナ）の入力は、全角（平仮名）だと登録出来ない' do
        @user.first_name_kana = 'えお'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '名（カナ）の入力は、全角（漢字）だと登録出来ない' do
        @user.first_name_kana = '名無'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '名（カナ）の入力は、全角記号だと登録出来ない' do
        @user.first_name_kana = '**'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width (Katakana) required')
      end
      it '生年月日が空だと登録出来ない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
