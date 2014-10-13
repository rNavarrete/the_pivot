require 'rails_helper'

RSpec.describe Order, :type => :model do
  it 'cannot make an order with a different status' do
    order = Order.new(status: 'waiting')
    expect(order.valid?).to eq(false)
  end
end
