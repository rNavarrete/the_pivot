require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Customer', type: :feature do
	before do
			@user = user_with({email_address: 'John@example.com', role: 'user'})
			@user.save
			login_as(@user)
			visit '/'
	end

	describe 'I can make purchases on any business I am browsing', type: :feature do

	 it 'does not create a duplicate order if user clicks back button after order confirmation' do
      expect(Order.all.count).to eq(10)
  		order_item
      expect(Order.all.count).to eq(11)
    end

		it 'can click on a store page' do
			first_store_link = first(:css, '.store-link')
			within(first_store_link) do
				first(:link).click
				end
			expect(page).to have_css(".store-header")
		end

		it 'can click on an item' do
			click_on("men")
			click_on("Mens")
			first_item = first(:css, '.store-item')
			within(first_item) do
				first(:link).click
			end
			expect(page).to have_css("#item-show-page")
		end

		it 'can click add to cart' do
			click_on("men")
			click_on("Mens")
			first_item = first(:css, '.store-item')
			within(first_item) do
				first(:link).click
			end
			click_on("add to cart")
			expect(page).to have_content("1 item")
		end

		it 'can complete checkout' do
			order_item
      order = Order.last
      expect(order.shipping_address.city).to eq("Denver")
			expect(order.billing_address.city).to eq("Pittsburgh")
			expect(order.order_items.count).to eq(1)
      expect(order.user_id).to eq(@user.id)
    end

		it 'can select size of item'
		it 'can select color of item'
		it 'receives an email confirmation of my order with basic order details and a link to the order detail page'
	end

	describe 'Manage my account information shared by all businesses centrally on my account page', type: :feature do
		it 'can change shipping address'
		it 'can change billing address'
		it 'can change credit cards associated with account'
		it 'can change name'
		it 'can change password'
	end

	describe 'Viewing past orders', type: :feature do
		it 'can click on my account'
		it 'can click on past orders'
		it 'can see all past orders from all businesses'
		it 'can click on an order to see order specifics'
	end

end
