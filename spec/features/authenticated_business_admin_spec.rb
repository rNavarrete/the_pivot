require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Business Administrator', type: :feature do
  before :each do
    @seller = user_with({email_address: "ghostface@sholin.com", role: "seller"})
    @seller.save
    @store = Store.create({name: "corner store", description: "Cooking up that incredible", user_id: @seller.id, slug: "ghosts_corner_store"})
    login_as(@seller)
    visit "/"
    click_link("Manage Store")
  end
  describe 'I can access the admin area', type: :feature do
    it 'can reach the seller dashboard' do
      expect(page).to have_content("Seller Dashboard")
    end
  end

  describe 'I can add new items to my store', type: :feature do
    it 'lets me add new items' do
      save_and_open_page


    end

    it 'can edit items'
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