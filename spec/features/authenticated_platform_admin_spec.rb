require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'As a platform administrator', type: :feature  do
  before do
    @admin = user_with({email_address: 'John@example.com', role: 'admin'})
    @admin.save

    @user= user_with({email_address: 'John1@example.com', role: 'user'})
    @user.save
    login_as(@user)
    visit '/'
  end

  it 'I can approve a business creation' do
    click_on("Open a Dope Store")
    page.fill_in('Name', with: "My Store")
    page.fill_in('Description', with: 'The best store on the web')
    page.fill_in('Slug', with: 'My_Store')
    page.fill_in('Request message', with: "I need to sell my threads")
    click_on ("Create Store")
    expect(page).not_to have_content("Open a Dope Store")
    visit '/My_Store'
    expect(page).to have_content("You have reached a store")
    click_on("Logout")
    login_as(@admin)
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    click_on("My_Store_approve")
    visit '/My_Store'
    expect(page).to have_content("My Store")
  end

  it 'I can deny a business creation' do
    create_a_dope_store
    expect(page).not_to have_content("Open a Dope Store")
    visit '/My_Store'
    expect(page).to have_content("You have reached a store")
    click_on("Logout")
    login_as(@admin)
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    click_on("My_Store_delete")
    visit '/My_Store'
    expect(page).not_to have_content("My Store")
  end

  it "can take a business offline where looking for an offline store redirects to the homepage and displays a 'under maintainence' message" do
    create_a_dope_store
    click_on("Logout")
    login_as(@admin)
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    click_on("My_Store_approve")
    visit '/My_Store'
    expect(page).to have_content("My Store")
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    page.find("#My_Store").click
    visit '/My_Store'
    expect(page).to have_content("You have reached a store")
  end

  it 'can bring back an offline business' do
    create_a_dope_store
    click_on("Logout")
    login_as(@admin)
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    click_on("My_Store_approve")
    page.find("#My_Store").click
    visit '/My_Store'
    expect(page).to have_content("You have reached a store")
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    page.find("#My_Store").click
    visit '/My_Store'
    expect(page).to have_content("My Store")

  end

  it 'Override/assist restaurant admins in any functionality available to them via the admin portion of their store pages' do
    create_a_dope_store
    click_on("Logout")
    login_as(@admin)
    click_on("Admin Dashboard")
    click_on("Manage Stores")
    click_on("My_Store_approve")
    visit '/My_Store'
    expect(page).to have_content("My Store")
    click_on("Admin Dashboard")
    click_on("Manage Store Details")
    page.find("#My_Store").click
    click_on("Create a New Item")
    within(:css, "#new_item") do
      page.fill_in("Name", with: "Kilo")
      page.fill_in("Description", with: "a kilo is one thousand grams")
      page.fill_in("Price", with: 30000)
      click_button('Create Item')
    end
    expect(page).to have_content("a kilo is one thousand grams")
  end
end
