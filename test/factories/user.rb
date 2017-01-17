FactoryGirl.define do

  factory :user do
    username        'didi'
    email           {"#{username}@nomagickshop.com".downcase}
    password_digest  User.digest('password')
    realname        'Diota Tanara'
    address         {Faker::Address.street_name}
    phone           '9991234'

    trait :admin do
      admin            true
    end

    trait :random do
      username        {"#{Faker::Name.unique.name}".underscore}
      email           {"#{Faker::Internet.unique.email}"}
      password_digest User.digest('password')
      realname        {Faker::Name.unique.name}
      address         {Faker::Address.street_name}
      phone           {Faker::Base.numerify('9######')}
    end

  end

end
