## Usersテーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| last_name        | string | null: false |
| first_name       | string | null: false |
| last_name_kana   | string | null: false |
| first_name_kana  | string | null: false |
| birthday         | date   | null: false |

### Association

- has_many :items
- has_many :orders


## Itemsテーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| title       | string     | null: false       |
| explain     | text       | null: false       |
| category_id | integer    | null: false       |
| status_id   | integer    | null: false       |
| charges_id  | integer    | null: false       |
| area_id     | integer    | null: false       |
| arrival_id  | integer    | null: false       |
| price       | integer    | null: false       |
| user        | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## Ordersテーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| user       | references | foreign_key: true |
| item       | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## Addressesテーブル

| Column         | Type       | Options          |
| -------------- | ---------- | ---------------- |
| postal_code    | string     | null: false      |
| prefectures_id | integer    | null: false      |
| municipalities | string     | null: false      |
| address        | string     | null: false      |
| building_name  | string     |                  |
| phone_number   | string     | null: false      |
| order          | references | foreign_key: true|

### Association

- belongs_to :order