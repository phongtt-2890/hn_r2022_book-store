FactoryBot.define do
  factory :user do
    name{Faker::Name.name_with_middle}
    email{Faker::Internet.email.downcase}
    phone{Faker::PhoneNumber.cell_phone}
    admin{false}
    activated{false}
    remember_digest{User.digest("remember_token")}
    password{"password"}
    password_confirmation{"password"}
  end
end
