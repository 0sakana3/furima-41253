# テーブル設計

## users テーブル     

| Column             | Type   | Options    |
| -------------------| ------ | -----------|
| nicname            | string | null:false |
| email              | string | null:false, foreign_key: true |
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
| category           | string | null:false |
| situation          | text   | null:false |
| shipping_fee       | integer | null:false |
| category           | string | null:false |
| region             | text   | null:false |
| time_required      | text   | null:false |
| price              | integer | null:false |
| user_id            | references | null:false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchaser

## purchasers テーブル

| Column             | Type       | Options    |
| ------------------ | ---------- | ---------- |
| user_id            | references | null:false, foreign_key: true |
| item_id            | references | null:false, foreign_key: true　|

### Association
- has_one :item
- has_one :user

## address テーブル

| Column             | Type   | Options    |
| ------------------ | ------ | ---------- |
| family_name        | string | null:false |
| first_name         | string | null:false |
| post_code          | string | null:false |
| city               | string | null:false |
| address            | string | null:false |
| building_name      | string | null:false |
| phone_number       | string | null:false |
| user_id            | references | null:false, foreign_key: true |

### Association
- has_one :purchaser