require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the user view', type: :feature do

  before do
    @user = user_with({email_address: 'John2@example.com'})
    @user.save
    visit categories_path
  end

    describe 'authentication', type: :feature do
      it 'can login' do
        login_as(@user)
        expect(page).to have_css('.button')
        expect(page).to have_link('Logout')
      end

      it 'can log out' do
        login_as(@user)
        page.click_link('Logout')
        expect(page).to have_button('Log In')
      end
    end

    describe 'account creation', type: :feature do
      it 'can create user credentials' do
        visit categories_path
        page.click_link('Create_Account')
        within("#email_address_field") do
          fill_in('Email address', :with => 'Joe@example.com')
        end
        within("#password_field") do
          fill_in('Password', :with => '1234')
        end
        page.fill_in('Password confirmation', with: '1234')
        page.fill_in('Full name', with: 'Joe User')
        page.click_button('Create User')
        user = user_with({email_address: 'Joe@example.com', password: "1234"})
        login_as(user)
        expect(page).to have_link('Logout')
      end
    end

    describe 'cart interaction', type: :feature do
      it 'returns to shopping after opening cart' do
        visit '/categories'
        page.find("#cart_btn").click
        page.find("#continue_shopping_btn").click
        end

      it 'adds item to cart' do
        create_item_associated_with_a_category
        visit '/categories'
        page.find('#cart_button').click
        click_on('cart')
        expect(page).to have_content('dandelion salad')
        expect(current_path).to eq(cart_path)
      end


      it 'can not proceed to checkout' do
          create_item_associated_with_a_category
          visit '/categories'
          page.find('#cart_button').click
          click_on('cart')
          click_on('check out')
          expect(current_path).to eq(new_user_path)
        end

      it 'removes item from cart' do
        create_item_associated_with_a_category
        visit '/categories'
        page.find('#cart_button').click
        click_on('cart')
        expect(page).to have_content('dandelion salad')
        click_on('Remove')
        expect(page).to_not have_content('dandelion salad')

      end

      it "changes number in quantity field" do
        create_item_associated_with_a_category
        visit '/categories'
        page.find('#cart_button').click
        click_on('cart')
        expect(page).to have_content('1')
        fill_in('quantity', :with => '5')
        click_on('update')
        expect(page).to have_content('5')
        expect(page).to_not have_content('1')
        end
    end
end
