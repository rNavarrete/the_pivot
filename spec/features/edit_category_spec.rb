require 'rails_helper'

RSpec.describe Item, type: :feature do
  it 'can edit a category from the admin face' do
    visit admin_categories_path
    click_link 'Desserts'

    expect(current_path).to eq(new_admin_category_path)

    fill_in 'Name', with: 'Desserts'
    click_button 'Save'
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_text('Category Successfully Created!')
  end
end
