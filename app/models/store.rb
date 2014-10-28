class Store < ActiveRecord::Base
	validates :name, uniqueness: true
  has_many :items
  has_many :orders
  belongs_to :user
end
