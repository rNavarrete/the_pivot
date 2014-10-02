require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

feature 'change item quantity in cart' do
  scenario 'UAU changes number in quantity field' do
    # Set up a cart with two items in it
    appetizers = Category.create(name: 'Appetizers')
    salad = appetizers.items.create(name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)
    soups = Category.create(name: 'Soups')
    nachos = soups.items.create(name: 'Nachos Chips', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)

    visit '/categories'
    within("#item-#{salad.id}") do #=> "#category-1"
      click_on('Add to cart')
    end

    visit '/categories'

    within("#item-#{nachos.id}") do
      click_on('Add to cart')
    end

    within("#item-#{nachos.id}") do
      fill_in('quantity', :with => '5')
      click_on('Update Quantity')
    end

    visit '/cart'

    within("#item-#{nachos.id}") do
      expect(page).to have_content('5')
      expect(page).to_not have_content('1')
    end

  end
end
