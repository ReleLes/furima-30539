class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :charges
  belongs_to_active_hash :area
  belongs_to_active_hash :arrival
end
