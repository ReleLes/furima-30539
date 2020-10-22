class Item < ApplicationRecord
  #↓があることで belongs_to_active_hashメソッドが使用できる
  extend ActiveHash::Associations::ActiveRecordExtensions
  #activehashを使用したアソシエーション
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :charges
  belongs_to_active_hash :area
  belongs_to_active_hash :arrival

  #アソシエーション
  belongs_to :user
  has_one_attached :image

  #空の情報は保存できない
  validate :title, presence: true
  validate :explain, presence: true
  validate :category, presence: true
  validate :status, presence: true
  validate :charges, presence: true
  validate :area, presence: true
  validate :arrival, presence: true
  validate :price, presence: true

  #選択時が「--」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1 }
  validates :status_id, numericality: { other_than: 1 }
  validates :charges_id, numericality: { other_than: 1 }
  validates :area_id, numericality: { other_than: 1 }
  validates :arrival_id, numericality: { other_than: 1 }
end
