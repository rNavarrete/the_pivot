require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe "As an Authenticated business manager", type: :feature do
  before :each do
    create_a_store_manager
  end

  describe 'I can add items', type: :feature do
    it 'lets me add new items' do
      within(:css, "#create_item") do
        page.fill_in("Name", with: "Push Pops")
        page.fill_in("Description", with: "Flintstones Brand Grape Flavor")
        page.fill_in("Price", with: 2)
        click_button('Create Item')
      end
      expect(page).to have_content("Flintstones Brand Grape Flavor")
      save_and_open_page
    end
  end
end