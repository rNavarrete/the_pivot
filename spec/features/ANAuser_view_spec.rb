require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the user view', type: :feature do

  describe 'cart interaction', type: :feature do
    before do
      create_item_associated_with_a_category
      visit '/categories'
    end
    it 'completes an order' do
      click_on('cart')
      user = user_with({email_address: 'John@example.com'})
      user.save
      page.fill_in('Email address', with: 'John@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      page.find("#continue_shopping_btn").click
      expect(page).to have_content('dandelion salad')
      page.find('#cart_button').click
      click_on('cart')
      page.find("#ckout_btn").click
      page.find("#pickup_btn").click
      expect(page).to have_css('#confirmation_message')
      page.find("#continue_shopping").click
      page.find("#cart_btn").click
      expect(page).to_not have_content('dandelion salad')
      order = Order.last
      expect(order.order_items.count).to eq(1)
      expect(order.order_items.last.id).to eq(1)
      expect(order.user_id).to eq(user.id)
    end

    it 'sees an item counter next to cart' do
      # appetizers = Category.create(name: 'Appetizers')
      # appetizers.items.create(id: 1, name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00, status: "active")
      # appetizers.save
      # visit '/categories'
      page.find('#cart_button').click
      page.find('#cart_button').click
      expect(page).to have_content('2')
    end

    it 'does not create a duplicate order if user clicks back button after order confirmation' do
      # appetizers = Category.create(name: 'Appetizers')
      # appetizers.items.create(id: 1, name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00, status: "active")
      # appetizers.save
      # visit '/categories'
      expect(Order.all.count).to eq(0)
      page.find('#cart_button').click
      user = user_with({email_address: 'John@example.com'})
      user.save
      page.fill_in('Email address', with: user.email_address)
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      page.find("#cart_btn").click
      page.find("#ckout_btn").click

      page.find("#pickup_btn").click
      visit verification_path
      page.find("#pickup_btn").click
      expect(Order.all.count).to eq(1)
    end

    # it 'is prompted for an address when designating pick up order'

    
  end
end
