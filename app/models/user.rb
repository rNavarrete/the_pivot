class User < ActiveRecord::Base
  has_secure_password

  # attr_accessible :name , :email

  # User::Roles
  # The available roles
  Roles = [ :admin , :user ]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
