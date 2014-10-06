require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the user view', type: :feature do

  describe 'cart interaction', type: :feature do
    it 'completes an order' do
      Order.create(status: "ordered")
      appetizers = Category.create(name: 'Appetizers')
      appetizers.items.create(name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)
      visit '/categories'
      click_on('Add to cart')
      user = user_with({email_address: 'John@example.com'})
      user.save
      page.fill_in('Email address', with: user.email_address)
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      page.find("#cart_btn").click
      expect(page).to have_content('dandelion salad')
      page.find("#ckout_btn").click
      save_and_open_page
      page.find("#pickup_btn").click
      expect(page).to have_css('#confirmation_message')
      click_button('continue shopping')
      click_button('Cart')
      expect(page).to_not have_content('dandelion salad')
      click_button('My Orders')
      expect(page).to have_css('.order_id')
    end
  end
end
