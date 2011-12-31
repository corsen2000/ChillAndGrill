class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  has_secure_password
  validates_presence_of :email, :first_name, :last_name, :on => :create

  def self.authenticate(user_id)
    User.find(user_id)
  end
end
