# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

appetizers = Category.create(name: 'Appetizers')
appetizers.items=Item.create([
  {name: 'Nachos', description: 'Chips and cheese yummy, yummy, yummy, yummy, yummy, yummy,', price: 5.00},
  {name: 'flaming cactus', description: 'Chips and cheese , yummy, yummy, yummy, yummy, yummy,', price: 5.00}
])

soups = Category.create(name: 'Soups')
soups.items=Item.create([
  {name: 'broccoli cheese soup', description: '2 types of cheese , yummy, yummy, yummy, yummy, yummy,', price: 5.00},
  {name: 'chili', description: 'with a deer we scraped off the bumper , yummy, yummy, yummy, yummy, yummy,', price: 5.00},
])

main_courses = Category.create(name: 'Main Course')
main_courses.items=Item.create([
  {name: 'jack rabbit steak', description: 'Chips and cheese, yummy, yummy, yummy, yummy, yummy,', price: 5.00},
  {name: 'dandilion salad', description: 'Chips and cheese , yummy, yummy, yummy, yummy, yummy,', price: 5.00},
])
