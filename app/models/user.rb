class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :current_password
  attr_accessor :current_password
  has_secure_password
  validates_presence_of :email, :first_name, :last_name
  validates :email, :email => true, :uniqueness => true
  validate :confirm_current_password, :on => :update

  def self.authenticate(user_id)
    User.find(user_id)
  end

  def confirm_current_password
    if authenticate(self.current_password) || self.password.blank?
      true
    else
      errors.add(:current_password, " is not correct")
      false
    end
  end

end
