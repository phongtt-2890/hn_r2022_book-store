FactoryBot.define do
  factory :user do
    name{Faker::Name.name_with_middle}
    email{Faker::Internet.email.downcase}
    phone{Faker::PhoneNumber.cell_phone}
    admin{false}
    confirmation_token{"confirm"}
    confirmed_at {DateTime.now}
    password{"password"}
    password_confirmation{"password"}
  end
end
