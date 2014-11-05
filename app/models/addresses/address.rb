class Address < ActiveRecord::Base
  has_many :orders
  belongs_to :user
  validates :street_address, presence: :true
  validates :city, presence: :true, format: { with: /\D/ }
  validates :state, length: {is: 2}, format: { with: /\A[a-zA-Z]+\z/ }
  validates :zip, presence: :true, numericality: :true

  self.inheritance_column = :category

  def self.categories
      %w(ShippingAddress BillingAddress)
  end

  def display

    "#{self.street_address.to_s} \n #{self.city.to_s}, #{self.state.to_s} #{self.zip.to_s}" 

  end


end
