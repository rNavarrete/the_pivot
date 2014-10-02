require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

feature 'add to cart' do
	scenario 'user adds item to cart' do
		appetizers = Category.create(name: 'Appetizers')
		appetizers.items.create(name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)
		visit '/categories'
		expect(page).to have_link('Add to cart')
		click_on('Add to cart')
		expect(page).to have_content('dandelion salad')
	end
end
