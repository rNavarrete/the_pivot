class Item < ActiveRecord::Base
  belongs_to :category
  validates :name, presence: :true
  validates :description length: { minimum: 25 }
  validates :price, presence: :true
  validates :price, numericality: { greater_than_or_equal_to: 0}
end
