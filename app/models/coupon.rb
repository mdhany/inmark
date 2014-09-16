class Coupon < ActiveRecord::Base
  belongs_to :login
  has_many :payments

  scope :mlm, -> { find_by(type_c: 1)}
  scope :comision, -> { find_by(type_c: 2)}

end
