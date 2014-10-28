class Store < ActiveRecord::Base
  has_many :items
  has_many :orders
  #belongs_to :user ???
end
