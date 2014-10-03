require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the user view', type: :feature do

  describe 'authentication', type: :feature do
    it 'can login' do
    user = user_with({email_address: 'John@example.com'})
    user.save
    login_as(user)
    visit '/'
      expect(page).to have_css('.button')
      expect(page).to have_link('Logout')
    end

    it 'can log out' do
      user = user_with({email_address: 'John2@example.com'})
      user.save
      visit items_path
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      page.click_link('Logout')
      expect(page).to have_button('Log In')
    end
  end

  describe 'account creation', type: :feature do
    it 'can create user credentials' do
      visit items_path
      page.click_link('Create_Account')
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.fill_in('Password confirmation', with: '1234')
      page.fill_in('Full name', with: 'Joe User')
      page.click_button('Create User')

      # expect(page).to have_content('Please Sign In To Your New Account')
      modify_items_from_dash
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Logout')
    end
  end

  describe 'cart interaction', type: :feature do
    it 'adds item to cart' do
      appetizers = Category.create(name: 'Appetizers')
      appetizers.items.create(name: 'dandelion salad', description: 'yummyyummyyummyyummyyummyyummyyummy', price: 5.00)
      visit '/categories'
      expect(page).to have_link('Add to cart')
      click_on('Add to cart')
      expect(page).to have_content('dandelion salad')
    end


    it 'removes item from cart' do
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

      # Visit the cart
      visit '/cart'

      #Check that chips are present
      expect(page).to have_content('Nachos Chips')

      # Remove one item
      within("#item-#{nachos.id}") do
        click_on('Remove')
      end
      # Test that item is no longer present
      expect(page).to_not have_content('Nachos Chips')
      # Test that non-removed item is present
      expect(page).to have_content('dandelion salad')
    end

    it "changes number in quantity field" do
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
end
