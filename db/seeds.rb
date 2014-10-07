appetizers   = Category.create(name: 'Appalachian Appetizers')
soups        = Category.create(name: 'Rocky Mountain Soups')
main_courses = Category.create(name: 'Mantiquierain Main Course', description: 'Served with a side salad')
gluten_free  = Category.create(name: 'Gluten Free')
desserts     = Category.create(name: 'Desserts')

item =Item.create([
  {name: 'Rocky Mountain Oysters',   description: 'Traditional bull balls served thinly sliced, deep fried and with a side of cocktail sauce.', price: 6.50, status: 'active', category_ids: [1]},
  {name: 'Flaming Cactus and Chips', description: 'Cactus from southern mexico mixed into our delicious cheese and served to your table on fire!', price: 6.00, status: 'active', category_ids: [1, 4]},
  {name: 'Creamy Artichoke & Spinach Dip', description: 'A local favorite, served with pretzel sticks and thick cut chips', price: 7.00, status: 'active', category_ids: [1, 4]},
  {name: 'Guacamole, Salsa and Chips', description: 'Watch you server mix what you want into the best guacamole you have tasted all day.', price: 7.50, status: 'active', category_ids: [1]},
  {name: 'Cheese Sticks', description: 'A house favorite. This is the one we struggle to keep the kitchen away from.', price: 5.50, status: 'retired', category_ids: [1]},

  {name: 'Kilimanjaro Kale and Potato Soup', description: 'Fresh kale, a perfect blend of seasonings and potatoes from the mountainous region of Idaho', price: 9.50, status: 'active', category_ids: [2, 4]},
  {name: 'Chili', description: 'This hearty dish is loaded with 4 types of beans and buffalo burger.', price: 10.99, status: 'active', category_ids: [2]},
  {name: 'Himalayan Thukpa', description: 'A traditional dish straight from Nepal.', price: 10.00, status: 'active', category_ids: [2, 4]},
  {name: 'Southwestern Tortilla Soup', description: 'We discovered the recipe for this rather spicy soup deep in the heart of the Andes Mountains.', price: 8.50, status: 'retired', category_ids: [2]},
  {name: 'Broccoli Cheese Soup', description: "The perfect light dish for the day when you want to stay warm but are not 'too' hungry.", price: 9.00, status: 'active', category_ids: [2]},

  {name: 'Ranier Ribeye',             description: 'Only the best beef is never frozen and marinated in our world famous marinade. Served with Mashed Potatoes.', price: 14.99, status: 'active', category_ids: [3, 4]},
  {name: 'The Mount McKinley Salad', description: 'People have traversed high ranges to get a taste of our Mckinley salad. This dish is sure to bring you back again.', price: 11.99, status: 'active', category_ids: [3]},
  {name: '5 Alarm Burger', description: 'Turn up the heat with jalapenos, pepper jack cheese, grilled onions and our house buffalo sauce.', price: 9.99, status: 'active', category_ids: [3]},
  {name: 'Rack of Ribs', description: 'Our ribs are slow smoked and practically fall off the bone. Basted in our house special BBQ sauce.', price: 15.99, status: 'active', category_ids: [3]},
  {name: 'Curry Vegabowl', description: 'Inspired by a hiking trip in India, this dish will make your tastebuds tingle', price: 12.99, status: 'active', category_ids: [3, 4]},

  {name: 'Peach Crisp with Vanilla Ice Cream', description: 'Our peach crisp is so good its illegal on most mountain tops.', price: 6.99, status: 'active', category_ids: [5]},
  {name: 'Carrot Cake', description: 'A good hearty dessert that will last you till morning.', price: 5.99, status: 'retired', category_ids: [5]},
  {name: 'Rhubarb Pie', description: 'Rhubarb grows wild and sometimes you can pick some while hiking. You do that and we will show you how to turn it into pie.', price: 5.99, status: 'active', category_ids: [5, 4]},
  {name: 'Hot Chocolate Supreme', description: 'We mix three types of chocolate and also build your mug out of chocalate so you can eat that too!', price: 8.99, status: 'active', category_ids: [5]},
  {name: 'Homemade Caramel Fondue', description: '', price: 5.00, status: 'active', category_ids: [5]}
])


User.create(full_name: 'Rachel Warbelow', email_address: 'demo+rachel@jumpstartlab.com', password: 'password', screen_name: '', role: 'user')
User.create(full_name: 'Jeff', email_address: 'demo+jeff@jumpstartlab.com', password: 'password', screen_name: 'j3', role: 'user')
User.create(full_name: 'Jorge Tellez', email_address: 'demo+jorge@jumpstartlab.com', password: 'password', screen_name: 'novohispano', role: 'user')
User.create(full_name: 'Josh Cheek', email_address: 'demo+josh@jumpstartlab.com', password: 'password', screen_name: 'josh', role: 'admin')
