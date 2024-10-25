FactoryBot.define do
  factory :item do
    item_name              { Faker::Name.initials(number: 2) }
    explanation            { Faker::Lorem.paragraph(sentence_count: 5) }
    category_id            { Faker::Number.between(from: 2, to: 11) }
    situation_id           { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_id        { Faker::Number.between(from: 2, to: 3) }
    prefecture_id          { Faker::Number.between(from: 2, to: 48) }
    time_required_id       { Faker::Number.between(from: 2, to: 4) }
    price                  { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
