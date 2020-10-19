## Usersテーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| nickname   | string | null: false |
| mail       | string | null: false |
| password   | string | null: false |
| name_kanji | string | null: false |
| name_kana  | string | null: false |
| birthday   | string | null: false |

### Association

- has_many :items
- has_many :orders


## Itemsテーブル

| Column   | Type       | Options     |
| -------- | ---------- | ----------- |
| title    | string     | null: false |
| explain  | string     | null: false |
| category | string     | null: false |
| status   | string     | null: false |
| charges  | string     | null: false |
| area     | string     | null: false |
| arrival  | string     | null: false |
| price    | string     | null: false |
| user     | references |             |

### Association

- belongs_to :user
- has_one :order


## Ordersテーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| order_date | string     | null: false |
| user       | references |             |
| item       | references |             |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address


## Addressesテーブル

| Column         | Type       | Options     |
| -------------- | ---------- | ----------- |
| postal_code    | string     | null: false |
| prefectures    | string     | null: false |
| municipalities | string     | null: false |
| address        | string     | null: false |
| building_name  | string     | null: false |
| phone_number   | string     | null: false |
| order          | references |             |

### Association

- belongs_to :order