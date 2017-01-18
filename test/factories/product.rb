require 'faker'


FactoryGirl.define do

  factory :product do
    title         "#{Faker::Book.title}"
    desc          "#{Faker::Lorem.paragraph(5)}"
    img_url       'http://mainsailbooks.co.uk/wp-content/uploads/2015/08/blankcover.jpg'
    price         Faker::Commerce.price
  end

end
