Category.create(name: 'Mens', position: 1)
Category.create(name: 'Womens', position: 2)
Category.create(name: 'Childrens', description: 'Served with a side salad', position: 3)
Category.create(name: 'Jackets', position: 4)
Category.create(name: 'Hats', position: 5)
Category.create(name: 'Accessories', position: 6)

Store.create(name: 'Trends', description: 'Trendy Clothes for Trendy People', image_file_name: 'trends.jpeg', user_id: 1)

item =Item.create([
  {name: 'Himalayan Hoodie',   description: 'A stylish top layer to keep you as warm as a Sherpa', price: 30.00, status: 'active', category_ids: [1,4], image_file_name: "HimalayanHoodie.jpg", store_id: 1},
  {name: 'Urban Sombrero', description: 'A modern nod to old Mexico', price: 45.00, status: 'active', category_ids: [1,2,5], image_file_name: "urbansombrero.jpg", store_id: 1},
  {name: 'Teddy Bear Jacket', description: 'Cold weather wear that you can cuddle up with', price: 55.00, status: 'active', category_ids: [2, 4], image_file_name: "teddybearjacket.jpg", store_id: 1},
  {name: 'Metro Duster', description: 'Old west style for a modern world', price: 27.00, status: 'active', category_ids: [1,4], image_file_name: "metro_duster.jpg", store_id: 1},
  {name: 'Fur Neck Wrap', description: 'Made from the fur of snowshoe hares', price: 28.00, status: 'active', category_ids: [1,2,6], image_file_name: "rabbit_fur.jpg", store_id: 1},
])

User.create(full_name: 'Rachel Warbelow', email_address: 'demo+rachel@jumpstartlab.com', password: 'password', screen_name: '', role: 'user')
User.create(full_name: 'Jeff', email_address: 'demo+jeff@jumpstartlab.com', password: 'password', screen_name: 'j3', role: 'user')
User.create(full_name: 'Jorge Tellez', email_address: 'demo+jorge@jumpstartlab.com', password: 'password', screen_name: 'novohispano', role: 'user')
User.create(full_name: 'Josh Cheek', email_address: 'demo+josh@jumpstartlab.com', password: 'password', screen_name: 'josh', role: 'admin')

order1  = Order.create(status: 'ordered',     user_id: 4)
order2  = Order.create(status: 'ordered',     user_id: 4)
order3  = Order.create(status: 'canceled',    user_id: 4)
order4  = Order.create(status: 'canceled',    user_id: 4)
order5  = Order.create(status: 'paid',        user_id: 4)
order6  = Order.create(status: 'paid',        user_id: 4)
order7  = Order.create(status: 'completed',   user_id: 4)
order8  = Order.create(status: 'completed',   user_id: 4)
order9  = Order.create(status: 'completed',   user_id: 4)
order10 = Order.create(status: 'completed',   user_id: 4)

order1.order_items.create(item_id:  1, quantity: 2)
order2.order_items.create(item_id:  1, quantity: 2)
order3.order_items.create(item_id:  1, quantity: 2)
order4.order_items.create(item_id:  1, quantity: 2)
order5.order_items.create(item_id:  1, quantity: 2)
order6.order_items.create(item_id:  1, quantity: 2)
order7.order_items.create(item_id:  1, quantity: 2)
order8.order_items.create(item_id:  1, quantity: 2)
order9.order_items.create(item_id:  1, quantity: 2)
order10.order_items.create(item_id: 1, quantity: 2)
