require 'rails_helper'

RSpec.describe Item, type: :feature do
  xit 'can create a category from the user face' do
    visit categories_path
    click_link 'Create'

    expect(current_path).to eq(new_category_path)

    fill_in 'Name', with: 'Deserts'
    clink_button 'Create Category'
    expect(current_path).to eq(category_path(Category.last))
    expect(page).to have_text('Category Successfuly Created!')
    expect(page).to have_text('New Category Title')
  end
end
