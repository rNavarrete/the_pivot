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

  describe 'user_creation', type: :feature do
    it 'can create user credentials' do
      visit items_path
      page.click_link('Create_Account')
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.fill_in('Password confirmation', with: '1234')
      page.fill_in('Full name', with: 'Joe User')
      page.click_button('Create User')
      page.fill_in('Email address', with: 'John2@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Logout')
    end
  end
end
