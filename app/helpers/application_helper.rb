module ApplicationHelper

  def type_coupon(type)
    current_login.coupons.find_by(type_c: type).id
  end




end
