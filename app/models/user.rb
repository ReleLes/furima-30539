class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items

  # 入力必須かつ、最大文字数が40文字以内であるバリデーション
  validates :nickname, presence: true, length: { maximum: 40 }

  # ユーザー本名入力必須かつ、全角（漢字・平仮名・カタカナ）での入力が必須であるバリデーション
  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/ } do
    validates :last_name
    validates :first_name
  end

  # ユーザー本名入力必須かつ、全角カタカナでの入力が必須であるバリデーション
  with_options presence: true, format: { with: /\A[ァ-ン]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

  validates :birthday, presence: true

  # パスワードが6文字以上かつ、半角英数字混合での入力が必要であるバリデーション
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX

  # メールアドレスの一意性
  validates :email, uniqueness: true
end
