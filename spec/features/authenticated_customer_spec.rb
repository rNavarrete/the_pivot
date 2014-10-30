require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Customer', type: :feature do
	describe 'I can make purchases on any business I am browsing', type: :feature do
		it 'can click on a store page'
		it 'can click on an item'
		it 'can select size of item'
		it 'can select color of item'
		it 'can click add to cart'
		it 'can complete checkout'
		it 'receives an email confirmation of my order with basic order details and a link to the order detail page'
	end

	describe 'Manage my account information shared by all businesses centrally on my account page', type: :feature do
		it 'can change shipping address'
		it 'can change billin address'
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
