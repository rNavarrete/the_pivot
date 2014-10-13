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
      page.find('#cart_button').click
      page.find('#cart_button').click
      expect(page).to have_content('2')
    end

    it 'does not create a duplicate order if user clicks back button after order confirmation' do
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

    it 'is prompted for an address when designating pick up order' do
      expect(Order.all.count).to eq(0)
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
      page.find("#delivery_btn").click
      page.fill_in('Street address', with: "123 Mountain Street")
      page.fill_in('City', with: 'Denver')
      page.fill_in('State', with: "Colorado")
      page.fill_in('Zip', with: '80228')
      page.click_button('Create Address')
      page.click_button('use this address')
      order = Order.last
      expect(Order.all.count).to eq(1)
      expect(order.address.city).to eq("Denver")
    end


  end

  describe 'user order', type: :feature do
    before do
      user = create(user_with)
      create_order_with_order_item(user)
      login_as(user)
      visit '/orders'
    end
    it 'shows order' do
      order = Order.last
        # save_and_open_page
      within '.orders_smorders' do
        first(:link).click
        # page.click_on '1'
      end

      expect(current_path).to eq(order_path(order))
    end

  end
end
