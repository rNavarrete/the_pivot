require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the admin view', type: :feature do
  describe 'admin tasks', type: :feature do
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


      # it 'can see dashboard' do
      #   visit items_path
      #   expect(page).to_not have_link('Admin Dashboard')
      #   page.fill_in('Email address', with: 'admin@example.com')
      #   page.fill_in('Password', with: '1234')
      #   page.click_button('Log In')
      #   expect(page).to have_link('Admin Dashboard')
      #   click_link 'Admin Dashboard'
      #   expect(page).to have_css('#dashboard_heading')
      # end

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

      it 'can modify item description =' do
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
        page.fill_in('Description', with: 'Muddy, muddy, Muddy, muddy, Muddy, muddy,Muddy, muddy,')
        click_button 'Save'
        click_link 'Desserts'
        click_link 'Mountain Mud Pie'
        expect(page).to have_content('Muddy, muddy, Muddy, muddy, Muddy, muddy,Muddy, muddy,')
      end

      it 'can modify item price =' do
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
        page.fill_in('Price', with: 5.50)
        click_button 'Save'
        click_link 'Desserts'
        click_link 'Mountain Mud Pie'
        expect(page).to have_content(5.50)
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
    user.save
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
    user = user_with({})
    user.save
    login_as(user)

    visit admin_categories_path
    click_link 'Create'

    expect(current_path).to eq(new_admin_category_path)

    fill_in 'Name', with: 'Desserts'
    click_button 'Save'
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_css('#listings')
  end

  it 'can create/delete an item when logged in as an admin' do
    user = user_with({})
    user.save
    login_as(user)

    visit items_path
    click_link 'Admin Dashboard'
    expect(page).to have_css('#dashboard')

    category_1 = Category.create(name: "Desserts")
    category_2 = Category.create(name: "Entres")

    click_link('Create a new Dish')
    fill_in 'Name', with: "Hamburger"
    fill_in 'Description', with: 'Yum Yum Yum Yum Yum Yum Yum Yum Yum'
    fill_in 'Price', with: '6.5'
    check('Entres')
    click_button 'Save'
    click_link 'Entres'
    save_and_open_page
    expect(page).to have_content('Hamburger')

    click_link('Hamburger')
    click_link('Delete this item')
    expect(page).to_not have_text('Hamburger')
  end

end
