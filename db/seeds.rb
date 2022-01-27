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
              publisher_id: Faker::Number.between(from: 1, to: 10),
              category_id: Faker::Number.between(from: 1, to: 10)
  )
end
