require 'faker'

FactoryGirl.define do
  factory :order do
    name      {Faker::Name.unique.name}
    email     {"#{Faker::Internet.unique.email}".underscore}
    address   {Faker::Address.street_address}
    pay_type  'Credit'
    shipped   false

    trait :transfer do
      pay_type  'Transfer'
    end

    trait :cash do
      pay_type  'Cash'
    end

    trait :paypal do
      pay_type  'PayPal'
    end

    trait :with_user do
      association :user
    end

    trait :without_user do
      user nil
    end

    trait :ten_days_ago do
      created_at 10.days.ago
    end

    trait :ten_months_ago do
      created_at 10.months.ago
    end

  end
end
