class User < ActiveRecord::Base
  ROLES = %w[admin moderator guest]

  has_many :rsvps  
  has_many :events, :through => :rsvps
  has_many :invitations
  has_many :notifications
  has_many :invited_events, :through => :invitations, :source => :event

  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :current_password, :roles
  attr_accessor :current_password

  has_secure_password

  validates_presence_of :email, :first_name, :last_name
  validates :email, :email => true, :uniqueness => true
  validate :confirm_current_password, :on => :update, :if => :changing_password

  before_save { |user| user.email.downcase! }

  scope :with_role, lambda { |role| where("roles_mask & #{2**ROLES.index(role.to_s)} > 0")}
  scope :approved, with_role("guest")

  def self.authenticate(user_id)
    User.find(user_id)
  end

  def self.roles_from_mask(mask)
    ROLES.reject { |r| ((mask || 0) & 2**ROLES.index(r)).zero? }
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
    User.roles_from_mask roles_mask
  end

  def roles_was
    User.roles_from_mask roles_mask_was
  end

  def role?(role)
    roles.include?(role.to_s)
  end

  def role_had?(role)
    roles_was.include?(role.to_s)
  end

  def full_name
    [first_name, last_name].join " "
  end

  def approved?    
    role?("guest")
  end

  def approve
    unless role?("guest")
      update_attribute(:roles, roles << "guest")
    end
  end

end