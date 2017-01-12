FactoryGirl.define do

  factory :user do
    username        'didi'
    email           {"#{username}@nomagickshop.com".downcase}
    password_digest  User.digest('password')
    realname        'Diota Tanara'
    address         'under the great blue sky'
    phone           '9991234'

    trait :admin do
      admin            true
    end
  end
end
