require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "As an Authenticated business manager", type: :feature do

  before :each do
    @seller = user_with(email_address: "ghostface@sholin.com", role: "seller")
    @seller.save
    @store = Store.create(authorized: "true", name: "corner store", description: "Cooking up that incredible", user_id: @seller.id, slug: "ghosts_corner_store")
    @item  = Item.create(name: 'Brick',   description: 'Some high quality fishscale', price: 30.00, status: 'active', category_ids: [6, 7], image_file_name: "HimalayanHoodie.jpg", store_id: @store.id, options: {"size" => "L"})
    login_as(@seller)
    visit "/"
    click_link("Manage My Store")
    @manager = user_with(full_name: "Raekwon", email_address: "thechef@sholin.com", role: 'user')
    @manager.save
    within(:css, "#managers") do
      fill_in("email", with: "thechef@sholin.com" )
      click_button("Add Manager")
    end
    click_on("Logout")
    login_as(@manager)
  end


  describe 'I can add items', type: :feature do
    it 'lets me add new items' do
    #   within(:css, "#create_item") do
    #     page.fill_in("Name", with: "Push Pops")
    #     page.fill_in("Description", with: "Flintstones Brand Grape Flavor")
    #     page.fill_in("Price", with: 2)
    #     click_button('Create Item')
    #   end
    #   expect(page).to have_content("Flintstones Brand Grape Flavor")
    end
  end
end