class Login < ActiveRecord::Base
  after_create :create_login_coupon

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :room
  has_many :payments
  has_many :coupons
  belongs_to :level
  has_and_belongs_to_many :messages
  has_many :notifications
  has_many :referrals, class_name: "Login",
           foreign_key: "sponsor_id"
  belongs_to :sponsor, class_name: "Login"


  scope :level_three, -> { where(position: 1).order(:position).limit(1) }
  scope :level_two, -> { where(position: [2,3]).order :position }
  scope :level_one, -> { where(position: [4,5,6,7]).order :position }


  #Validations
  validates :first_name, :last_name, presence: true, length: {maximum: 24}
  validates :username, presence: true, uniqueness: true, length: {maximum: 18}
  validates :identification, presence: true, uniqueness: true, numericality: true, length: {maximum: 18}
  validates :country, presence: true


  private
  def set_default_role
    self.role ||= Role.find_by_name('beginner')
  end

  def create_login_coupon
    self.coupons.create type_c: 1, name: "Swissgolden", amount: 0
    self.coupons.create type_c: 2, name: "Comisión", amount: 0

  end


end
