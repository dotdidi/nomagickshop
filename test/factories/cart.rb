FactoryGirl.define do
  factory :cart do
    trait :with_user do
      association :user, :admin
    end

    trait :without_user do
      user nil
    end
  end
end
