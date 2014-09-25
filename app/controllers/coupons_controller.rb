class CouponsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_coupon, only: [:show]

  def index
    @coupons = current_login.coupons
  end

  def show
    @payments = @coupon.payments
  end

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

end
