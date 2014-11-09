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
			first_item = first(:css, '.grid-item')
			within(first_item) do
				first(:link).click
			end
			expect(page).to have_css("#item-show-page")
		end

		it 'can click add to cart' do
			click_on("men")
			click_on("Mens")
			first_item = first(:css, '.grid-item')
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

		it "is prompted for a shipping address and a billing address when ordering if they don't exist" do
			click_on("men")
			click_on("Mens")
			first_item = first(:css, '.grid-item')
			within(first_item) do
				first(:link).click
			end
			click_on("add to cart")
			click_on("cart")
			page.find("#delivery_btn").click
			expect(page).to have_content("Shipping Address")
			complete_shipping_address
			expect(page).to have_content("Billing Address")
		end
		it "can add new addresses as part of checkout" do
			click_on("men")
			click_on("Mens")
			first_item = first(:css, '.grid-item')
			within(first_item) do
				first(:link).click
			end
			click_on("add to cart")
			click_on("cart")
			page.find("#delivery_btn").click
			complete_shipping_address
			complete_billing_address
			click_on("New Billing Address")
			complete_billing_address
			expect(page).to have_content("Philadelphia")
			click_on("New Shipping Address")
			complete_shipping_address
			expect(page).to have_content("Atlanta")
		end

		it "associates a billing and shipping address with an order" do
			order_item
			order = Order.last
			expect(order.shipping_address.city).to eq("Denver")
			expect(order.billing_address.city).to eq("Pittsburgh")
		end

		it 'can select size of item' do
			visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      page.select "XL", :from => "options_sizes"
      click_on("add to cart")
      click_on("cart")
      expect(page).to have_content("XL")
		end

		it 'can select color of item' do
			visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.grid-item')
      within(first_item) do
        first(:link).click
      end
      page.select "Fat", :from => "options_colors"
      click_on("add to cart")
      click_on("cart")
      expect(page).to have_content("Fat")
		end
	end

	describe 'Manage my account information shared by all businesses centrally on my account page', type: :feature do
		it 'can create a shipping address' do
			click_on("You")
			click_on("My Addresses")
			click_on("New Shipping Address")
			complete_shipping_address
			expect(page).to have_content("Atlanta")
		end

		it 'can create a billing address' do
			click_on("You")
			click_on("My Addresses")
			click_on("New Shipping Address")
			complete_billing_address
			expect(page).to have_content("Philadelphia")
		end

		it 'can edit an address' do
			click_on("You")
			click_on("My Addresses")
			click_on("New Shipping Address")
			complete_billing_address
			click_on("edit")
			page.fill_in('Zip', with: '80111')
			click_on("Update Address")
			expect(page).to have_content("80111")
		end

		it 'can delete an address' do
			click_on("You")
			click_on("My Addresses")
			click_on("New Shipping Address")
			complete_billing_address
			expect(page).to have_content("80234")
			click_on("Delete Address")
			expect(page).not_to have_content("80234")
		end

		it 'can change username' do
			click_on("You")
			click_on("My Account Details")
			page.fill_in('Email address', with: 'John2@test.com')
			click_on("Update User")
			expect(page).to have_content("John2@test.com")
		end

		it 'can change password' do
			click_on("You")
			click_on("My Account Details")
			page.fill_in('Password', with: '12345678')
			page.fill_in('Password confirmation', with: '12345678')
			click_on("Update User")
			click_on('Logout')
			page.fill_in('email_address', with: "John@example.com")
			page.fill_in('Password', with: '12345678')
			page.click_button('Log In')
			expect(page).to have_content("John@example.com")
		end
	end

	describe 'Viewing past orders', type: :feature do
		it 'can click on past orders' do
			click_on("You")
			click_on("My Orders")
			expect(page).to have_content("Status")
		end

		it 'can see all past orders from all businesses' do
			click_on("You")
			click_on("My Orders")
			expect(page).to have_content("Ordered From")
		end

		it 'can click on an order to see order specifics' do
			order_item
			visit '/orders'
			table = first(:css, '.tg')
			within(table) do
				first(:link).click
			end
			expect(page).to have_content("Ordered From")
		end
	end

end
