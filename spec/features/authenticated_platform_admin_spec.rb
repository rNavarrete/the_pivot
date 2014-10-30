require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'


describe 'As a platform administrator', type: :feature  do
  it 'I can approve a business creation'
  it 'I can deny a business creation'
  it "can take a business offline where looking for an offline store redirects to the homepage and displays a 'under maintainence' message"
  it 'can bring back an offline business'
  it 'Override/assist restaurant admins in any functionality available to them via the admin portion of their restaurant pages'
end