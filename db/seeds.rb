10.times do
  name = Faker::Book.unique.publisher
  address = Faker::Address.full_address
  phone = Faker::PhoneNumber.phone_number
  website = "https://www.google.com"
  Publisher.create!(name: name,
                    address: address,
                    phone: phone,
                    website: website
  )
end

10.times do
  name = Faker::Book.unique.genre
  description = Faker::Lorem.sentence(word_count: 15)
  Category.create!(name: name,
                   description: description
  )
end

50.times do
  name = Faker::Book.unique.title
  description = Faker::Lorem.sentence(word_count: 50)
  num_pages = Faker::Number.between(from: 50, to: 1000)
  price = Faker::Commerce.price(range: 1..100.0, as_string: true)
  publish_year = Faker::Date.between(from: '2000-01-01', to: '2022-01-01')
  quantity = Faker::Number.between(from: 0, to: 5000)
  Book.create!(name: name,
              description: description,
              num_pages: num_pages,
              price: price,
              publish_year: publish_year,
              quantity: quantity,
              publisher_id: Publisher.all.pluck(:id).sample,
              category_id: Category.all.pluck(:id).sample
  )
end

User.create!(name: "Admin",
  email: "admin@bookstore.com",
  password: "123123",
  password_confirmation: "123123",
  phone: Faker::PhoneNumber.phone_number,
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

50.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               phone: Faker::PhoneNumber.phone_number,
               activated: true,
               activated_at: Time.zone.now
  )
end

20.times do
  Author.create!(name: Faker::Name.name,
                 description: Faker::Lorem.sentence(word_count: 30)
  )
end

50.times do
  BookAuthor.create!(author_id: Author.all.pluck(:id).sample,
                     book_id: Book.all.pluck(:id).sample
  )
end
