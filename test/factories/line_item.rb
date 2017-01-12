FactoryGirl.define do

  factory :line_item do
    product

    trait :with_user do
      association :cart, :with_user
    end

    trait :without_user do
      association :cart, :without_user
    end
  end

end
