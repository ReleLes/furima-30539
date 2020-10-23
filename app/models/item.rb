class Item < ApplicationRecord
  # ↓があることで belongs_to_active_hashメソッドが使用できる
  extend ActiveHash::Associations::ActiveRecordExtensions
  # activehashを使用したアソシエーション
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :charge
  belongs_to_active_hash :area
  belongs_to_active_hash :arrival

  # アソシエーション
  belongs_to :user
  has_one_attached :image

  # 空の情報は保存できない
  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :explain, length: { maximum: 1000 }
    validates :price
    validates :image
  end

  # 選択時が「--」の時は保存できないようにする
  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :area_id
    validates :arrival_id
  end
  # priceには半角数字のみ保存できる
  VALID_PRICE_REGEX = /\A[0-9]+\z/i.freeze
  validates :price, format: { with: VALID_PRICE_REGEX }

  # 価格の範囲のバリデーション(300〜9999999)
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
