require 'rails_helper'

RSpec.describe Item, :type => :model do
  it 'can create an item' do
    item = Item.new(name: 'possum pie', description: "delicious", price: 5, category_id: 1)
    expect(item.valid?).to eq(true)
  end

  it 'will not create an item if it does not have a name' do
    
  end
  it 'will not create an item if it does not have a description of at least 25 characters'
  it 'will not create an item if it does not have a price of greater than zero'
end
