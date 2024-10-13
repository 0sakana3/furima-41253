class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :date_of_birth, presence: true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'Must contain both half-width alphanumeric characters' }

  VALID_NAME_REGEX = /\A[ぁ-んァ-ン一-龥]/
  VALID_NAMEKANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :family_name, format: { with: VALID_NAME_REGEX, message: 'Full-width (Kanji, Hiragana, Katakana) required' }
  validates :first_name, format: { with: VALID_NAME_REGEX, message: 'Full-width (Kanji, Hiragana, Katakana) required' }
  validates :family_name_kana, format: { with: VALID_NAMEKANA_REGEX, message: 'Full-width (Katakana) required' }
  validates :first_name_kana, format: { with: VALID_NAMEKANA_REGEX, message: 'Full-width (Katakana) required' }
end
