require 'rails_helper'
describe Item do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の保存' do
    context '商品が保存できる場合' do
      it '商品登録時フォームの入力必須欄が存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'titleが40文字以下で登録できる' do
        @item.title = 'abcdefghijklmnopqrstuvwxyz12345678901234'
        expect(@item).to be_valid
      end
      it 'explainが1000文字以下で登録できる' do
        @item.explain = 'CyKpHsQx4Bn1N4sFgYoNb34QkClHfKa3EgLx5ZyY
        nI1zW8iCfTdK7g7L6b4A5rG5gTwByQgZa5StUiZ3wCdJ3rLaJvP61pFy8
        LuI0gV9q1KtT0f2Sz4I0gKvVl4HeXgE9v2E40dJwT12hK53aT5kCcFjJk
        Co55Fk5JaU7lAzI2yXhS4tOfLfRwL4dCjNcQj16Z7k8Cp4N5eZz0C6y4G
        4eXc1YbToKm4S1eJvRxHm0J8vFnOrFb5J0uA8i5UwHi103V53dB12536e
        ZhG13sN8tNd43Rm7X1zByIx48NlZaT0sCeSfLxKpUzIq59X7zVfMjU8p6
        8QqPzF4g1VzRwNcImP24pAgCz31EnDrCd5G24tF5qY0wI18nXjHnHe44Q
        79sP2v6V0cRb7UaDnPfZh60Iw0CcIy8Zl421MrAs57V7bR8c6QuN25hYr
        5PxGbCaPqOuJi3IzJn47WfUtMt8KqYh5ZbI28i055Ed8O9vD2lCiUaJ84
        tQpFlUvJv2L42tOnFnWvLfLw5NtPsF885e6TuQf7Zh7UyYn5CkVsRbS19
        rE9xY6sLbMuTgTuG7rYxPb5QuU2eVg1C0dGvOhWbIy7C1pAoDiXaL5nBx
        Aw8U9dReHbEwY7e7P0t0Lx42O4kCzW5s492OoBi2OnJ426fSuZ6bKo39C
        jXcQyNx0XoBuH8e3Ec525T8dHh8ThQlPuZkPs3N1bQyU7yFtAqNrIbAbS
        s2MnAj5TmOqCe6Fu0TpN13pLw7UuBlW2tL2rVkEw932JoOdEi8M1dIzK4'
        expect(@item).to be_valid
      end
      it 'category_idがid:1以外を選択されていれば登録できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'status_idがid:1以外を選択されていれば登録できる' do
        @item.status_id = 2
        expect(@item).to be_valid
      end
      it 'charge_idがid:1以外を選択されていれば登録できる' do
        @item.charge_id = 2
        expect(@item).to be_valid
      end
      it 'area_idがid:1以外を選択されていれば登録できる' do
        @item.area_id = 2
        expect(@item).to be_valid
      end
      it 'arrival_idがid:1以外を選択されていれば登録できる' do
        @item.arrival_id = 2
        expect(@item).to be_valid
      end
      it 'priceの値が300~9,999,999以内であれば登録できる' do
        @item.price = 5000
        expect(@item).to be_valid
      end
    end

    context '商品が保存できない場合' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'titleが空では保存できない' do
        @item.title = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Title can't be blank")
      end
      it 'explainが空では保存できない' do
        @item.explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end
      it 'category_idがid:1では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end
      it 'status_idがid:1では保存できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Status must be other than 1")
      end
      it 'charge_idがid:1では保存できない' do
        @item.charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge must be other than 1")
      end
      it 'area_idがid:1では保存できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Area must be other than 1")
      end
      it 'arrival_idがid:1では保存できない' do
        @item.arrival_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Arrival must be other than 1")
      end
      it 'priceが空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceの値が300~9,999,999以外では保存できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
      end
      it 'priceの値が半角数字以外は保存できない' do
        @item.price = "5千円"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end
    
    
    
  end
  
end
