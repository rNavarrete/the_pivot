require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the admin view', type: :feature do

  describe 'authentication', type: :feature do
    User.create(full_name: "John", email_address: 'admin@example.com', password: '1234', password_confirmation: "1234", role: 'admin')

    it 'can see dashboard' do

      visit items_path
      expect(page).to_not have_link('Admin Dashboard')
      page.fill_in('Email address', with: 'admin@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Admin Dashboard')
      click_link 'Admin Dashboard'
      expect(page).to have_css('#dashboard_heading')
    end
  end
end
