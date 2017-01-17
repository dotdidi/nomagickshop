require 'faker'

FactoryGirl.define do
  factory :order do
    name      {Faker::Name.unique.name}
    email     {"#{Faker::Internet.unique.email}".underscore}
    address   {Faker::Address.street_address}
    pay_type  'credit_card'

    trait :debit_card do
      pay_type  'debit_card'
    end

    trait :cash do
      pay_type  'cash_on_delivery'
    end

    trait :paypal do
      pay_type  'paypal'
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
