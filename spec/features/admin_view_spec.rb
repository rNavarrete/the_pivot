require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the admin view', type: :feature do

  describe 'admin tasks', type: :feature do
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

    it 'can modify item name =' do
      category_1 = Category.create(name: "Desserts")
      category_2 = Category.create(name: "Entres")
      Item.create(name: "Mountain Mud Pie", description: "yummy, yummy, yummy, yummy, yummy", price: 3.50, categories: [category_1])

      visit items_path
      page.fill_in('Email address', with: 'admin@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      click_link 'Admin Dashboard'
      click_link 'Dishes'
      click_link 'Desserts'
      click_link 'Mountain Mud Pie'
      page.fill_in('Name', with: 'Valley Mud Pie')
      click_button 'Save'
      click_link 'Desserts'
      expect(page).to have_content('Valley Mud Pie')

    end
  end

  it 'can_change_item_category' do
    category_1 = Category.create(name: "Desserts")
    category_2 = Category.create(name: "Entres")
    Item.create(name: "Mountain Mud Pie", description: "yummy, yummy, yummy, yummy, yummy", price: 3.50, categories: [category_1])

    visit items_path
    page.fill_in('Email address', with: 'admin@example.com')
    page.fill_in('Password', with: '1234')
    page.click_button('Log In')
    click_link 'Admin Dashboard'
    click_link 'Dishes'
    click_link 'Dessert'
    click_link 'Mountain Mud Pie'
    check('Entres')
    click_button 'Save'
    click_link 'Entres'
    expect(page).to have_content('Mountain Mud Pie')

  end

end
