class Ortu < ActiveRecord::Base

	has_many :kids, dependent: :destroy
	has_many :pictures, as: :pictureable, dependent: :destroy
	belongs_to :user

end