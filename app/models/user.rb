class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :current_password, :roles
  attr_accessor :current_password

  has_secure_password

  validates_presence_of :email, :first_name, :last_name
  validates :email, :email => true, :uniqueness => true
  validate :confirm_current_password, :on => :update, :if => :changing_password

  scope :with_role, lambda { |role| where("roles_mask & #{2**ROLES.index(role.to_s)} > 0")}

  ROLES = %w[admin moderator guest]

  def self.authenticate(user_id)
    User.find(user_id)
  end

  def confirm_current_password
    if User.find(self).try(:authenticate, @current_password)
      true
    else
      errors.add(:current_password, " is not correct")
      false
    end
  end

  def changing_password
    not @password.blank?
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

end