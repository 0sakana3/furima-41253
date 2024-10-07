# テーブル設計

## users テーブル     

| Column             | Type   | Options    |
| -------------------| ------ | -----------|
| nicname            | string | null:false |
| email              | string | null:false, unique: true|
| encrypted_password | string | null:false |
| family_name        | string | null:false |
| first_name         | string | null:false |
| family_name_kana   | string | null:false |
| first_name_kana    | string | null:false |
| date_of_birth      | date   | null:false |

### Association
- has_many :items
- has_many :purchasers

## items テーブル

| Column             | Type   | Options    |
| ------------------ | ------ | ---------- |
| item_name          | string | null:false |
| explanation        | text   | null:false |
| category_id        | integer | null:false |
| situation_id       | integer | null:false |
| shipping_fee_id    | integer | null:false |
| city_id      | integer | null:false |
| time_required_id   | integer | null:false |
| price              | integer | null:false |
| user               | references | null:false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchaser

## purchasers テーブル

| Column          | Type       | Options    |
| --------------- | ---------- | ---------- |
| user            | references | null:false, foreign_key: true |
| item            | references | null:false, foreign_key: true |

### Association
- belongs_to :item
- has_many :user
- has_one : address

## addresses テーブル

| Column             | Type   | Options    |
| ------------------ | ------ | ---------- |
| post_code          | string | null:false |
| prefecture         | string | null:false |
| city               | string | null:false |
| address            | string | null:false |
| building_name      | string |  |
| phone_number       | string | null:false |
| purchaser          | references | null:false, foreign_key: true |

### Association
- has_one :purchaser