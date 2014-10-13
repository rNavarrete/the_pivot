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
  end
end
