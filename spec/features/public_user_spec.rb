require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As a Public User', type: :feature do

  describe 'browsing' do
    it 'can click on a category and see items' do
      visit '/'
      click_on("men")
      click_on("Mens Bottoms")
      expect(page).to have_content("Mens Bottoms")
    end

    it 'can click on a business name and see store page' do
      visit '/'
      click_on("men")
      click_on("Gasp Jeans")
      expect(page).to have_css("#store-name")
    end

    it 'can click on an item and see item page' do
      visit '/'
      click_on("men")
      click_on("Mens")
      first_item = first(:css, '.store-item')
      within(first_item) do
        first(:link).click
      end
      expect(page).to have_css("#item-show-page")
    end

  end

  describe 'cart interaction', type: :feature do

    it 'maintains a shared shopping cart across all businesses I browse'

    it 'can add items to a shopping cart'

    it 'must log in before completing checkout'

    it 'after logging in, I immediately resume the checkout process'

  end

  describe 'creating/managing an account' do
    it 'can create an account'

    it 'expects to receive a welcome email after creating account'

    it 'can request that my account become a business owner'
  end

end
