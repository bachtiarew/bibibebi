class Ortu < ActiveRecord::Base

	has_many :kids, dependent: :destroy
	has_many :pictures, as: :pictureable
	belongs_to :user

end