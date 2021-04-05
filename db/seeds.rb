OrderProduct.delete_all
ProductCategory.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
User.delete_all

User.create(username:   "Guest",
  password:   "guestpassword",
  powerlevel: 0,
  email:      "guest@sharkshack.ca",
  active:     1)

toys = Category.create(name: "Toys")
apparel = Category.create(name: "Apparel")
food = Category.create(name: "Food")
sale = Category.create(name: "Sale")

count = 0
5.times do
  toy = Product.create(name:        "Shark " + Faker::Games::Dota.unique.item,
                       desc:        Faker::Games::Dota.quote,
                       price:       rand(100..1000),
                       weight:      rand(10..99),
                       category_id: toys.id,
                       status:      1)
  ProductCategory.create(product: toy, category: toys)

  apa = Product.create(name:        "Shark " + Faker::Commerce.unique.product_name,
                       desc:        "For the " + Faker::Verb.ing_form + ", " + Faker::Verb.ing_form + ", " + Faker::Verb.ing_form + " shark.",
                       price:       rand(100..1000),
                       weight:      rand(10..99),
                       category_id: apparel.id,
                       status:      1)
  ProductCategory.create(product: apa, category: apparel)

  fude = Product.create(name:        "Shark " + Faker::Food.unique.dish,
                        desc:        Faker::Food.description + " Made for sharks.",
                        price:       rand(100..1000),
                        weight:      rand(10..99),
                        category_id: food.id,
                        status:      1)
  ProductCategory.create(product: fude, category: food)
  count += 1
  next unless count <= 5

  ProductCategory.create(product: toy, category: sale)
  ProductCategory.create(product: apa, category: sale)
  count = 0
end

Product.all.each do |prod|
  query = URI.encode_www_form_component([prod.name, prod.categories[0].name].join(","))
  downloaded_image = URI.open("https://source.unsplash.com/400x400/?#{query}")
  prod.image.attach(io:       downloaded_image,
                    filename: "i-#{prod.name}.jpg")
  puts("#{prod.name} - image found")
  sleep(1)
end

