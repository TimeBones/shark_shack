OrderProduct.delete_all
ProductCategory.delete_all
Order.delete_all
Product.delete_all
Category.delete_all
User.delete_all

User.create(username:   "Tim",
            password:   "password",
            powerlevel: 1,
            email:      "timbones@bones.com",
            active:     1)
toys = Category.create(name: "Toys")
apparel = Category.create(name: "Apparel")
food = Category.create(name: "Food")

3.times do
  toy = Product.create(name:        "Shark " + Faker::Games::Dota.unique.item,
                       desc:        Faker::Games::Dota.quote,
                       price:       rand(100..1000),
                       weight:      rand(10..99),
                       category_id: toys.id,
                       status:      1)
  ProductCategory.create(product: toy, category: toys)
  puts(toy.name)

  apa = Product.create(name:        "Shark " + Faker::Commerce.unique.product_name,
                       desc:        Faker::Games::Dota.quote,
                       price:       rand(100..1000),
                       weight:      rand(10..99),
                       category_id: apparel.id,
                       status:      1)
  ProductCategory.create(product: apa, category: apparel)
  puts(apa.name)

  foo = Product.create(name:        "Shark " + Faker::Food.unique.dish,
                       desc:        Faker::Food.description,
                       price:       rand(100..1000),
                       weight:      rand(10..99),
                       category_id: food.id,
                       status:      1)
  ProductCategory.create(product: foo, category: food)
  puts(foo.name)
end
