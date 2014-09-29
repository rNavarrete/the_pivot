require 'rails_helper'

RSpec.describe Category, :type => :model do

  describe 'create categories' do
    it 'can create a category' do
      category = Category.create(name: "Soups", description: "delicious")
      expect(category.description).to eq('delicious')
    end

    it 'will not create a category if it does not have a name' do
      category = Category.new(description: 'yummy')
      expect(category.valid?).to eq(false)
    end
  end
end
