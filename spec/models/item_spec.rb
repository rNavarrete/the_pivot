require 'rails_helper'

RSpec.describe Item, :type => :model do
  it 'can create an item' do
    item = Item.new(name: 'possum pie', description: "delicious pie made of the possum that tried to eat out of our garbage last week", price: 5, category_id: 1)
    expect(item.valid?).to eq(true)
  end

  it 'will not create an item if it does not have a name' do
    item = Item.new(description: "delicious", price: 5, category_id: 1)
    expect(item.valid?).to eq(false)
  end

  it 'will not create an item if it does not have a description of at least 25 characters' do
    item = Item.new(name: 'possum pie', price: 5, category_id: 1)
    expect(item.valid?).to eq(false)
  end

  it 'will not create an item if it does not have a price of greater than zero' do
    item = Item.new(name: 'possum pie', description: "delicious", price: -5, category_id: 1)
    expect(item.valid?).to eq(false)
  end
end
