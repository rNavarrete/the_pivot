class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :user
  validates :street_address, presence: :true
  validates :city, presence: :true
  validates :state, presence: :true
  validates :zip, presence: :true 



end
