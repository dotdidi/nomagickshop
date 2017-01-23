require 'faker'

FactoryGirl.define do
  factory :transaction do
    card_type         "Visa"
    card_expires_on   "#{Date.today + 1.months}"
    card_number       "4111111111111111"
    card_verification "100"

    trait :invalid_card do
      card_number     "4222222222222222"
    end

    trait :expires do
      card_expires_on "#{Date.today - 1.months}"
    end
    trait :with_response do
      action        "Purchase"
      amount        "#{Faker::Commerce.price}"
      success       Faker::Boolean.boolean
      authorization "#{Faker::Crypto.md5}"
      message       "#{Faker::Lorem.sentence}"
      params        "{}"
    end
  end
end
