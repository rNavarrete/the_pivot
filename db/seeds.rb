# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

appetizers = Category.create(name: 'Appalachian Appetizers')
appetizers.items=Item.create([
  {name: 'Rocky Mountain Oysters', description: 'Traditional bull balls served thinly sliced, deep fried and with a side of cocktail sauce.', price: 5.00, status: 'active'},
  {name: 'Flaming Cactus and Chips', description: 'Cactus from southern mexico mixed into our delicious cheese and served to your table on fire!', price: 5.00, status: 'active'}
])

soups = Category.create(name: 'Rocky Mountain Soups')
soups.items=Item.create([
  {name: 'Kilimanjaro Kale and Potato Soup', description: 'Fresh kale, a perfect blend of seasonings and potatoes from the mountainous region of Idaho', price: 5.00, status: 'active'},
  {name: 'Chili', description: 'This hearty dish is loaded with 4 types of beans and buffalo burger.', price: 5.00, status: 'active'},
])

main_courses = Category.create(name: 'Mantiquierain Main Course', description: 'Served with a side salad')
main_courses.items=Item.create([
  {name: 'Ribeye Steak', description: 'Only the best beef is never frozen and marinated in our world famous marinade. Served with Mashed Potatoes.', price: 5.00, status: 'active'},
  {name: 'The Mount McKinley Salad', description: 'People have traversed high ranges to get a taste of our Mckinley salad. This dish is sure to bring you back again.', price: 5.00, status: 'active'},
])
