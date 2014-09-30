class User < ActiveRecord::Base
  has_secure_password

  validates :full_name, presence: true
  validates_format_of :email_address, :with => /.+@.+\..+/i
  validates :email_address, uniqueness: true
end
