class FormObjects
  include ActiveModel::Model
  attr_accessor :postal_code, :prefectures_id, :municipalities, :address, :building_name, :phone_number, :user_id, :item_id, :token, :price

  # 空の情報は保存できない
  with_options presence: true do
    validates :token
    validates :item_id
    validates :user_id
    # 郵便番号に関するバリデーション
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :municipalities
    validates :address
    # 0〜9数字のみで11桁以内
    validates :phone_number, format: { with: /\A[0-9]+\z/i }, length: { maximum: 11 }
  end
  # 選択時が「--」の時は保存できないようにする
  validates :prefectures_id, numericality: { other_than: 1 }

  def save
    # 商品情報とユーザー情報を保存
    order = Order.create(user_id: user_id, item_id: item_id)
    # 住所の情報を保存
    Address.create(postal_code: postal_code, prefectures_id: prefectures_id, municipalities: municipalities, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
