FactoryBot.define do
  factory :user do
    nickname              { 'test' }
    email                 { 'test@example' }
    password              { '000000' }
    password_confirmation { password }
    family_name           { '山田' }
    first_name            { '太郎' }
    family_name_kana      { 'ヤマダ' }
    first_name_kana       { 'タロウ' }
    date_of_birth         { '1949-10-12' }
  end
end
