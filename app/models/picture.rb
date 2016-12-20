class Picture < ActiveRecord::Base
	mount_uploader :picture_url, PhotoUploader
	belongs_to :pictureable, polymorphic: true
	
end	