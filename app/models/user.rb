class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
t.string :last_name,          null: false
t.string :first_name,         null: false
t.string :last_name_kana,     null: false
t.string :first_name_kana,    null: false
t.date   :birthday            null: false

t.string :nickname,           null: false, default: ""