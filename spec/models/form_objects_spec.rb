require 'rails_helper'

RSpec.describe FormObjects, type: :model do
  describe '商品の購入' do
    before do
      sleep 0.5
      @form = FactoryBot.build(:form_objects)
    end

    context '商品が購入できる場合' do
      it '商品購入時フォームの入力必須欄が存在すれば登録できる' do
        expect(@form).to be_valid
      end
      it '商品購入時建物名が空でも登録できる' do
        @form.building_name = ''
        expect(@form).to be_valid  
      end
    end

    context '商品が購入できない場合' do
      it 'postal_codeが空では保存できない' do
        @form.postal_code = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeにハイフンがないと保存できない' do
        @form.postal_code = '1234567'
        @form.valid?
        expect(@form.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'municipalitiesが空では保存できない' do
        @form.municipalities = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Municipalities can't be blank")
      end
      it 'addressが空では保存できない' do
        @form.address = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Address can't be blank")
      end
      it 'prefectures_idがid:1では保存できない' do
        @form.prefectures_id = 1
        @form.valid?
        expect(@form.errors.full_messages).to include('Prefectures must be other than 1')
      end
      it 'phone_numberが空では保存できない' do
        @form.phone_number = ''
        @form.valid?
        expect(@form.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it 'phone_numberは11桁以下でないと保存できない' do
        @form.phone_number = 123_456_789_012
        @form.valid?
        expect(@form.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end
      it 'phone_numberはハイフンが入っていると保存できない' do
        @form.phone_number = 1234 - 56_789
        @form.valid?
        expect(@form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'tokenが空では保存できない' do
        @form.token = nil
        @form.valid?
        expect(@form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
