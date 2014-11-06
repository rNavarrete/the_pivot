 require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Business Administrator', type: :feature do
  before :each do
    @seller = user_with(email_address: "ghostface@sholin.com", role: "seller")
    @seller.save
    @store = Store.create(authorized: "true", name: "corner store", description: "Cooking up that incredible", user_id: @seller.id, slug: "ghosts_corner_store")
    @item  = Item.create(name: 'Brick',   description: 'Some high quality fishscale', price: 30.00, status: 'active', category_ids: [6, 7], image_file_name: "HimalayanHoodie.jpg", store_id: @store.id, options: {"size" => "L"})
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
      within(:css, "#create_item") do
        page.fill_in("Name", with: "Kilo")
        page.fill_in("Description", with: "a kilo is one thousand grams")
        page.fill_in("Price", with: 30000)
        click_button('Create Item')
      end
      expect(page).to have_content("a kilo is one thousand grams")
    end

    it 'lets me edit items' do
      click_link("Edit")
      page.fill_in("Name", with: "Herb")
      page.fill_in("Description", with: "a pound is 453 grams easy to remember")
      page.fill_in("Price", with: 9000)
      click_button('Update Item')
      expect(page).to have_content("a pound is 453 grams easy to remember")
    end

    it 'can edit items and add an option' do
      click_link("Edit")
      page.fill_in("Name", with: "Herb")
      page.fill_in("Description", with: "a pound is 453 grams easy to remember")
      page.fill_in("Price", with: 9000)
      page.fill_in("options_size", with: "1,2,3")
      click_button('Update Item')
      expect(page).to have_content("Sizes")
    end

    it 'can retire items' do
      expect(page).to_not have_content("retired")
      click_link("Edit")
      select "Retired", :from => "Status"
      click_button('Update Item')
      expect(page).to have_content("retired")
    end

    it 'can add an item with options' do
      within(:css, "#create_item") do
        page.fill_in("Name", with: "Kilo")
        page.fill_in("Description", with: "a kilo is one thousand grams")
        page.fill_in("Price", with: 30000)
        page.fill_in("options_sizes", with: "1,2,3")
        click_button('Create Item')
      end
      expect(page).to have_content("Sizes")
    end
  end

  describe 'I can update the details of my business', type: :feature do
    it 'can update its name' do
      within(:css, "#store_settings") do
        expect(page).to_not have_content("still have the best Colombian")
        page.fill_in("Name", with: "The brothel")
        page.fill_in("Description", with: "still have the best Colombian")
        click_button('Update Store')
        expect(page).to have_content("still have the best Colombian")
      end
    end

    it 'can update its URL identifier' do
      within(:css, "#store_settings") do
        expect(page).to_not have_content("rae_and_ghosts_wonder_emporium")
        page.fill_in("Slug", with: "rae_and_ghosts_wonder_emporium")
        click_button('Update Store')
        visit ('/rae_and_ghosts_wonder_emporium')
      end
      expect(page).to have_content("Some high quality fishscale")
    end

    it 'can update its description' do
      within(:css, "#store_settings") do
        page.fill_in("Description", with: "red tops, green tops, yellow tops")
        click_button('Update Store')
      end
      expect(page).to have_content("red tops, green tops, yellow tops")
    end
  end

  describe 'I can add or remove other admins from the business', type: :feature do
    it 'can delete fellow store admins'
    it 'shouldn\'t have less than one site administrator'
    it 'can add fellow store admins'
    it 'can perform the admin actions that were available in dinner dash (add/edit items etc)'
  end
end
