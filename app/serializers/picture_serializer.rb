class PictureSerializer < ApplicationSerializer

	attributes(
		:id
		:picture_id,
		:pictureable_type,
		:picture_url
		)
	
end