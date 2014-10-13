require 'rails_helper'

RSpec.describe Item, :type => :model do



  let(:order_item) do
    @item = Item.create(name: 'possum pie', description: "delicious, yummy, delicious, yummy, delicious, yummy,delicious, yummy,delicious, yummy,", price: 5, status: "active")
    OrderItem.new(order_id: 1, item_id: @item.id, quantity: 3 )
  end

  it 'is valid' do
    expect(order_item).to be_valid
  end

  it 'is not valid without a order_id' do
    order_item.order_id = nil
    expect(order_item).to_not be_valid
  end

  it 'is not valid without an item_id' do
    order_item.item_id = nil
    expect(order_item).to_not be_valid
  end

  it 'calculates a line total' do
    expect(order_item.line_total).to eq(15)
  end

end
