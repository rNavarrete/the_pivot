require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'



describe 'As a registered user', type: :feature do

  describe 'a registered user can request to become a business account', type: :feature do

    it 'can request to create a new business that includes a name, URL identifier, and description'

    it 'must notify the platform administrators of pending request'
  end

  describe 'if platform administrators approve request' do

    it 'will notify requester by mail'

    it 'will make the requestor a business administrator instantly'
  end

  describe 'if platform administrators deny request' do

    it 'will notify the requestor by mail'
  end
end