require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいく場合' do
      it '新規登録時フォームの入力必須欄が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'nicknameが40文字以下で登録できる' do
        @user.nickname = 'abcdefghijklmnopqrstuvwxyz12345678901234'
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上かつ、英数字混合であれば登録できる' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it 'last_nameが全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.last_name = '漢字ひらがなカタカナ'
        expect(@user).to be_valid
      end
      it 'first_nameが全角（漢字、ひらがな、カタカナ）であれば登録できる' do
        @user.first_name = '漢字ひらがなカタカナ'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カナのみであれば登録できる' do
        @user.last_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角カナのみであれば登録できる' do
        @user.first_name_kana = 'カタカナ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかない場合' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'nicknameが40文字以上であれば登録できない' do
        @user.nickname = 'abcdefghijklmnopqrstuvwxyz123456789012345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname is too long (maximum is 40 characters)')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailに＠が含まれていなければ登録できない' do
        @user.email = 'test.gmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = 'abc123'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameは全角（漢字、ひらがな、カタカナ）でなければ登録できない' do
        @user.last_name = 'lastname'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameは全角（漢字、ひらがな、カタカナ）でなければ登録できない' do
        @user.first_name = 'firstname'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaは全角カナでなければ登録できない' do
        @user.last_name_kana = 'らすと名前'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaは全角カナでなければ登録できない' do
        @user.first_name_kana = 'ふぁーすと名前'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
