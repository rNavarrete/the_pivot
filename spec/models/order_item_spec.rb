require 'rails_helper'

RSpec.describe Item, :type => :model do
  let(:order_item) do
  OrderItem.new(order_id: 1, item_id: 2)
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
end
