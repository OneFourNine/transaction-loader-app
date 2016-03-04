class Tenant < ActiveRecord::Base
  def lock!(user)
    update_attributes(user_key: user, remaining_time: 2.hours.from_now)
  end

  def unlock!
    update_attributes(user_key: nil, remaining_time: nil)
  end

  def locked?(user=nil)
    return false unless resident?
    user_key != user || remaining_time < Time.current
  end

  def resident?
    user_key.present? && remaining_time.present?
  end
end
