class PictureSerializer < ApplicationSerializer

	attributes(
		:id,
		:pictureable_id,
		:pictureable_type,
		:picture_url
		)
	
end