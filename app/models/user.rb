class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
  has_secure_password
  validates_presence_of :email, :first_name, :last_name, :on => :create
end
