class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.welcome_email(user).deliver
  end

  def around_update(user)
    making_guest = user.role?("guest") && !user.role_had?("guest")
    yield
    if making_guest
      UserMailer.approval_email(user).deliver
    end
  end
end