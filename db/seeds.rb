user = User.new
user.email = 'test@example.com'
user.password = '12345678'
user.password_confirmation = '12345678'
user.save!

10.times do
  Driver.create!(
    name: Faker::Name.first_name,
    surname: Faker::Name.last_name
  )
end

10.times do
  BrandShop.create!(name: Faker::Address.city)
end

10.times do
  ExternalShop.create!(
    name: Faker::Address.city,
    daily_payments: true
    )
end

10.times do
  ExternalShop.create!(
    name: Faker::Address.city,
    daily_payments: false
    )
end

10.times do
  TruckRoute.create!(
    name: Faker::Address.city,
    weekdays: '1, 3, 5'
    )
end

10.times do
  TruckRoute.create!(
    name: Faker::Address.city,
    weekdays: '2, 4, 6'
    )
end

date = Time.now
10.times do
  10.times do
    GeneralExpense.create!(
      name: Faker::Lorem.words(2).join(' '),
      value: rand(1..9999),
      date: date
      )
  end
  date -= 1.day
end

drivers = Driver.all
truck_routes = TruckRoute.all
brand_shops = BrandShop.all
external_shops = ExternalShop.all

date = Time.now
10.times do
  10.times do
    Income.create!(
      value: rand(500..1999),
      date: date,
      driver: drivers.sample,
      truck_route: truck_routes.sample
    )
  end
  date -= 1.day
end

date = Time.now
10.times do
  10.times do
    Income.create!(
      value: rand(500..1999),
      date: date,
      brand_shop: brand_shops.sample
    )
  end
  date -= 1.day
end

date = Time.now
10.times do
  10.times do
    Income.create!(
      value: rand(500..1999),
      date: date,
      external_shop: external_shops.sample
    )
  end
  date -= 1.day
end
