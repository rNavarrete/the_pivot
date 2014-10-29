require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As a Public User', type: :feature do

  describe 'cart interaction', type: :feature do

    it 'maintains a shared shopping cart across all businesses I browse'

    it 'can add items to a shopping cart'

    it 'must log in before completing checkout'

    it 'after logging in, I immediately resume the checkout process'

  end

  describe 'creating/managing an account' do
    it 'can create an account'

    it 'expects to receive a welcome email after creating account'

    it 'can request that my account become a business owner'
  end

end
