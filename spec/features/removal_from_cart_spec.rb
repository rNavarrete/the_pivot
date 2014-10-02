require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

feature 'remove from cart' do
  scenario 'UAU user removes item from cart' do
    pending
    # Set up a cart with two items in it
    appetizers = Category.create(name: 'Appetizers')
    salad = appetizers.items.create(name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)
    soups = Category.create(name: 'Soups')
    nachos = soups.items.create(name: 'Nachos Chips', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)

    visit '/categories'
    within("#{salad.id}") do
      click_on('Add to cart')
    end

    within("#{nachos.id}") do
      click_on('Add to cart')
    end

    # Visit the cart
    visit '/cart'

    #Check that chips are present
    expect(page).to have_content('Nachos Chips')

    # Remove one item
    within("#{nachos.id}") do
      click_on('Remove')
    end
    # Test that item is no longer present
    expect(page).to_not have_content('Nachos Chips')
    # Test that non-removed item is present
    expect(page).to have_content('dandelion salad')
  end
end
