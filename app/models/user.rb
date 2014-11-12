class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :addresses
  has_many :shipping_addresses
  has_many :billing_addresses
  has_many :stores, through: :store_managers
  has_many :store_managers
  has_one :store

  validates :full_name, presence: true
  validates_format_of :email_address, :with => /\A[-0-9a-zA-Z.+_]+@[-0-9a-zA-Z.+_]+\.[a-zA-Z]{2,4}\z/i
  validates :email_address, uniqueness: true

  Roles = [ :admin , :user, :seller ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end

end
