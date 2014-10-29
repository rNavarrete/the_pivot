require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'As an Authenticated Business Administrator', type: :feature do
  describe 'I can manage my store', type: :feature do
    it 'can add items'
    it 'can edit items'
    it 'can retire items'
  end

  describe 'I can update the details of my business', type: :feature do
    it 'can update its name'
    it 'can update its URL identifier'
    it 'can update its description'
  end

  describe 'I can add or remove other admins from the business', type: :feature do
    it 'can delete fellow store admins'
    it 'shouldn\'t have less than one site administrator'
    it 'can add fellow store admins'
    it 'can perform the admin actions that were available in dinner dash (add/edit items etc)'
  end
end