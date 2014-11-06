Category.create(name: 'Mens', position: 1)
Category.create(name: 'Mens Pants', position: 2)
Category.create(name: 'Mens Shirts', position: 3)
Category.create(name: 'Mens Jackets', position: 4)
Category.create(name: 'Mens Shoes', position: 5)
Category.create(name: 'Womens', position: 6)
Category.create(name: 'Womens Dresses', position: 7)
Category.create(name: 'Womens Accessories', position: 8)
Category.create(name: 'Womens Bags & Purses', position: 9)
Category.create(name: 'Womens Shoes', position: 10)
Category.create(name: 'Boys', position: 11)
Category.create(name: 'Girls', position: 12)
Category.create(name: 'Babies & Toddlers', position: 13)
Category.create(name: 'Kids Shoes', position: 14)

Store.create(name: 'Trends', description: 'Trendy Clothes for Trendy People', image_file_name: 'trendz.jpg', user_id: 1, slug: "trends")
Store.create(name: 'Gasp Jeans', description: "The Word's Most Pretentious Jeans", image_file_name: 'gasp.jpg', user_id: 2, slug: "gasp_jeans")
Store.create(name: 'Inappropriate Cultural Appropriation', description: "Pay a Lot of Money to Pretend Like You're Poor!", image_file_name: 'approp.jpg', user_id: 3, slug: "inappropriate_cultural_appropriation")
Store.create(name: 'Abercrombie & The Other Guy', description: "We Are Better than You", image_file_name: 'abercrombie.jpeg', slug: "abercrombie", user_id: 5)
Store.create(name: 'Pure Lava', description: 'Our Clothes Literally Burn You', image_file_name: 'lava.jpg', slug: 'lava', user_id: 6)
Store.create(name: 'Abidas', description: 'So close to the real thing.', image_file_name: 'abidas.jpg', slug: 'abidas', user_id: 7)
#new custom stores go right above me!

item =Item.create([
  {name: 'Himalayan Hoodie',   description: 'A stylish top layer to keep you as warm as a Sherpa', price: 30.00, status: 'active', category_ids: [6, 7], image_file_name: "HimalayanHoodie.jpg", sizes: "S,M,L", colors: "Red,Blue,Green", store_id: 3},
  {name: 'Urban Sombrero', description: 'A modern nod to old Mexico', price: 45.00, status: 'active', category_ids: [1,6,8], image_file_name: "urbansombrero.jpg", sizes: "54cm,57.8cm,60.6cm", store_id: 3},
  {name: 'Teddy Bear Jacket', description: 'Cold weather wear that you can cuddle up with', price: 55.00, status: 'active', category_ids: [6, 8, 12], image_file_name: "teddybearjacket.jpg", sizes: "S,M,L", colors: "Brown", store_id: 1},
  {name: 'Metro Duster', description: 'Old west style for a modern world', price: 27.00, status: 'active', category_ids: [1,4], image_file_name: "metro_duster.jpg", sizes: "S,M,L,XL,XXL", colors: "Black,Grey", store_id: 1},
  {name: 'Fur Neck Wrap', description: 'Made from the fur of snowshoe hares', price: 28.00, status: 'active', category_ids: [6,8], image_file_name: "rabbit_fur.jpg", sizes: "S,M,L", colors: "Black,White,Grey", store_id: 2},
  {name: 'Invisible Shirt', description: "You can't see it because it doesn't exist!", price: 550.00, status: 'active', category_ids: [1,3], image_file_name: 'invisible_shirt.jpg', sizes: "S,M", colors: "Invisible", store_id: 4},
  {name: 'Two Left Shoes', description: 'Perfect if you have two left feet', price: 53.95, status: 'active', category_ids: [1,5,6,10], image_file_name: 'left_shoes.jpg', sizes: "5,6,7,8,9,9.5,10,10.5,11,12", colors: "Red,Orange,Yellow,Blue,Black", store_id: 6},
  {name: 'Liquid Lava Coat', description: 'The hottest coat in town', price: 123.00, status: 'active', category_ids: [1,6,4], image_file_name: 'lava_coat.jpg', sizes: "S,M,L,XL", colors: "Red,Orange,Yellow", store_id: 5},
  {name: 'Fat Pants', description: "If you're above size 32, guys, we think you're a fattie and we charge you more!", price: 2332.00, status: 'active', category_ids: [1,2], image_file_name: 'fat_pants.jpg', sizes: "L,XL", colors: "Fat", store_id: 4},
  {name: 'Kids Cool-Magma Pants', description: 'Get Stoned Kids!', price: 52.10, status: 'active', category_ids: [11,12,13], image_file_name: 'magma_pants.jpg', sizes: "2,2.5,3,3.5,4,4.5", colors: "Red,Orange,Yellow", store_id: 5},
  #new custom items go right above me!
])


User.create(full_name: 'Rachel Warbelow', email_address: 'demo+rachel@jumpstartlab.com', password: 'password', screen_name: '', role: 'seller')
User.create(full_name: 'Jeff', email_address: 'demo+jeff@jumpstartlab.com', password: 'password', screen_name: 'j3', role: 'user')
User.create(full_name: 'Jorge Tellez', email_address: 'demo+jorge@jumpstartlab.com', password: 'password', screen_name: 'novohispano', role: 'seller')
User.create(full_name: 'Josh Cheek', email_address: 'demo+josh@jumpstartlab.com', password: 'password', screen_name: 'josh', role: 'admin')
User.create(full_name: 'D-bag', email_address: 'd_bag@example.com', password: 'password', screen_name: 'd_bag', role: 'seller')
User.create(full_name: 'Hot Lava', email_address: 'lava@example.com', password: 'password', screen_name: 'laval', role: 'seller')
User.create(full_name: 'Slave Driver', email_address: 'slaves@example.com', password: 'password', screen_name: 'slaves', role: 'seller')
#new custom users go right above me!

100.times do |i|
  user = User.create!(
    full_name: Faker::Name.name,
    email_address: Faker::Internet.email,
    password: 'password',
    role: 'user'
    )
end


order1  = Order.create(status: 'ordered',     user_id: 4, store_id: 1)
order2  = Order.create(status: 'ordered',     user_id: 4, store_id: 1)
order3  = Order.create(status: 'canceled',    user_id: 4, store_id: 1)
order4  = Order.create(status: 'canceled',    user_id: 4, store_id: 1)
order5  = Order.create(status: 'paid',        user_id: 4, store_id: 2)
order6  = Order.create(status: 'paid',        user_id: 4, store_id: 2)
order7  = Order.create(status: 'completed',   user_id: 4, store_id: 2)
order8  = Order.create(status: 'completed',   user_id: 4, store_id: 3)
order9  = Order.create(status: 'completed',   user_id: 4, store_id: 3)
order10 = Order.create(status: 'completed',   user_id: 4, store_id: 3)

order1.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order2.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order3.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order4.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order5.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order6.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order7.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order8.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order9.order_items.create(item_id:  1, quantity: 2, options: {"sizes" => "S"})
order10.order_items.create(item_id: 1, quantity: 2, options: {"sizes" => "S"})
