require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the user view', type: :feature do
User.create(email_address: 'John@example.com', password: '1234', password_confirmation: "1234")

    describe 'authentication', type: :feature do

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
end
