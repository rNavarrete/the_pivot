require 'rails_helper'

RSpec.describe Category, :type => :model do
    let(:address) do
    Address.new(street_address: "123 Mountain Street", city: "Joe Test", state: 'CO', zip: "80228")
  end


    it 'is valid' do
      expect(address).to be_valid
    end

    it 'is invalid without a street address' do
      address.street_address = nil
      expect(address).to_not be_valid
    end

  it 'is invalid without a city' do
    address.city = nil
    expect(address).to_not be_valid
  end

  it 'is invalid without a state' do
    address.state = nil
    expect(address).to_not be_valid
  end

  it 'is invalid without a zip' do
    address.zip = nil
    expect(address).to_not be_valid
  end
end
