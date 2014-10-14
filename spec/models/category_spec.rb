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

    it 'will order by position' do
      category2 = Category.create(name: 'grubs', position: 2)
      category1 = Category.create(name: 'rodents', position: 1)
      category3 = Category.create(name: 'worms', position: 3)

      expect(Category.last).to eq(category3)
      expect(Category.first).to eq(category1)
    end
  end
end
