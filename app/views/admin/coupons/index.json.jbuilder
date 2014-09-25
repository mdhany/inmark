json.array!(@admin_coupons) do |admin_coupon|
  json.extract! admin_coupon, :id
  json.url admin_coupon_url(admin_coupon, format: :json)
end
