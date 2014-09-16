class Room < ActiveRecord::Base

  belongs_to :level
  has_many :logins

end
