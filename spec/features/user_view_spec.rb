require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the user view', type: :feature do

  describe 'authentication', type: :feature do
    User.create(full_name: "John", email_address: 'John@example.com', password: '1234', password_confirmation: "1234")

    it 'can login' do

      visit items_path
      page.fill_in('Email address', with: 'John@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Logout')
    end

    it 'can log out' do
      visit items_path
      page.fill_in('Email address', with: 'John@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      page.click_link('Logout')
      expect(page).to have_button('Log In')
    end
  end

  describe 'user_creation', type: :feature do
    it 'can create user credentials' do
      visit items_path
      page.click_link('Create_Account')
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.fill_in('Password confirmation', with: '1234')
      page.fill_in('Full name', with: 'Joe User')
      page.click_button('Create User')
      expect(page).to have_content('Please Sign In To Your New Account')
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Logout')
    end
  end
end
