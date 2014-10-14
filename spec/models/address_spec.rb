require 'rails_helper'

RSpec.describe Address, :type => :model do
  describe 'checking validations' do
    it 'accepts numbers for the zipcode' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: 'CO', zip: 80526)
      expect(address).to be_valid
    end

    it 'will not accept letters for zipcode' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: 'CO', zip: 'fjgkd')
      expect(address).to_not be_valid
    end

    it 'will not accept numbers in city' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 7685, state: 'CO', zip: 80526)
      expect(address).to_not be_valid
    end

    it 'will not accept numbers in state' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: '7474', zip: 80526)
      expect(address).to_not be_valid
    end

    it 'will accept letters in city' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: 'CO', zip: 80526)
      expect(address).to be_valid
    end

    it 'will accept letters in state' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: 'CO', zip: 80526)
      expect(address).to be_valid
    end

    it 'will not accept more than two letters for the state field' do
      address = Address.new(street_address: "6708 Bitterroot Dr", city: 'Colorado springs', state: 'Colorado', zip: 80526)
      expect(address).to_not be_valid
    end
  end

  describe 'base expectations' do
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
end
