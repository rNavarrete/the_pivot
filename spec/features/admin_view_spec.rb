require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'the admin view', type: :feature do

  describe 'authentication', type: :feature do

    it 'can see dashboard' do
      visit items_path
      expect(page).to_not have_link('Admin Dashboard')
      user = user_with({})
      user.save
      page.fill_in('Email address', with: 'admin@example.com')
      page.fill_in('Password', with: '1234')
      page.click_button('Log In')
      expect(page).to have_link('Admin Dashboard')
      click_link 'Admin Dashboard'
      expect(page).to have_css('#dashboard_heading')
    end
  end

  it 'can delete a category when logged in as an admin' do
    user = user_with({})
    user.save
    login_as(user)
    visit items_path
    click_link 'Admin Dashboard'
    expect(page).to have_css('#dashboard')

    click_link('Create a new food Category')
    expect(page).to have_content('Create Category')
    fill_in 'Name', with: 'Desserts'
    click_button 'Save'

    expect(page).to have_css('#listings')
    click_link('Desserts')
    click_link('Delete this category')
    expect(page).to_not have_text('Desserts')
  end

  it 'can create and edit a category from the admin face' do
    user = user_with({})
    login_as user

    visit admin_dashboard_path

    expect(page).to have_css('#dashboard')

    click_link('Create a new food Category')
    expect(page).to have_content('Create Category')
    fill_in 'Name', with: 'Desserts'
    click_button 'Save'

    expect(page).to have_css('#listings')
    click_link('Desserts')

    fill_in 'Name', with: 'Burrito'
    click_button 'Save'
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_css('#listings')
  end

  it 'can create a category from the admin face' do
    visit admin_categories_path
    click_link 'Create'

    expect(current_path).to eq(new_admin_category_path)

    fill_in 'Name', with: 'Desserts'
    click_button 'Save'
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_css('#listings')
  end

  it 'can create/edit/delete an item when logged in as an admin' do
    user = user_with({})
    user.save
    login_as(user)
    visit items_path
    click_link 'Admin Dashboard'
    expect(page).to have_css('#dashboard')

    click_link('Create a new Dish')
    fill_in 'Name', with: "Hamburger"
    fill_in 'Description', with: 'Yum Yum Yum Yum Yum Yum Yum Yum Yum'
    fill_in 'Price', with: '6.5'
    click_button 'Save'
    expect(page).to have_content('Hamburger')

    click_link('Hamburger')
    fill_in 'Name', with: 'HamBurger and Fries'
    click_button 'Save'
    expect(page).to have_content('HamBurger and Fries')

    click_link('HamBurger and Fries')
    click_link('Delete this item')
    expect(page).to_not have_text('HamBurger and Fries')
  end

end
