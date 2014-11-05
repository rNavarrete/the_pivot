require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Business Administrator', type: :feature do
  before :each do
    @seller = user_with(email_address: "ghostface@sholin.com", role: "seller")
    @seller.save
    @store  = Store.create(name: "corner store", description: "Cooking up that incredible", user_id: @seller.id, slug: "ghosts_corner_store")
    @item =   Item.create(name: 'Himalayan Hoodie',   description: 'A stylish top layer to keep you as warm as a Sherpa', price: 30.00, status: 'active', category_ids: [6, 7], image_file_name: "HimalayanHoodie.jpg", store_id: @store.id)
    login_as(@seller)
    visit "/"
    click_link("Manage Store")
  end

  describe 'I can access the admin area', type: :feature do
    it 'can reach the seller dashboard' do
      expect(page).to have_content("Seller Dashboard")
      save_and_open_page
    end
  end

  describe 'I can add new items to my store', type: :feature do
    it 'lets me add new items' do
      within(:css, "#create_item") do
        page.fill_in("Name", with: "Kilo")
        page.fill_in("Description", with: "a kilo is one thousand grams")
        page.fill_in("Price", with: 30000)
        click_button('Create Item')
      end
      expect(page).to have_content("a kilo is one thousand grams")
    end

    # it 'lets me edit items' do

    # end



    it 'can retire items'
  end

  describe 'I can update the details of my business', type: :feature do
    it 'can update its name'
    it 'can update its URL identifier'
    it 'can update its description'
  end

  describe 'I can add or remove other admins from the business', type: :feature do
    it 'can delete fellow store admins'
    it 'shouldn\'t have less than one site administrator'
    it 'can add fellow store admins'
    it 'can perform the admin actions that were available in dinner dash (add/edit items etc)'
  end
end