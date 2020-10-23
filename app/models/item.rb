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
  validates :title, presence: true, length: { maximum: 40 }
  validates :explain, presence: true, length: { maximum: 1000 }
  validates :category, presence: true
  validates :status, presence: true
  validates :charge, presence: true
  validates :area, presence: true
  validates :arrival, presence: true
  validates :price, presence: true
  validates :image, presence: true

  # 選択時が「--」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1 }
  validates :status_id, numericality: { other_than: 1 }
  validates :charge_id, numericality: { other_than: 1 }
  validates :area_id, numericality: { other_than: 1 }
  validates :arrival_id, numericality: { other_than: 1 }

  # priceには半角数字のみ保存できる
  VALID_PRICE_REGEX = /\A[0-9]+\z/i.freeze
  validates :price, format: { with: VALID_PRICE_REGEX }

  # 価格の範囲のバリデーション(300〜9999999)
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
