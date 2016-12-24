module KidHelper

	def get_kids(parent_id)
		kids = Kid.where(ortu_id: parent_id)
		@kids = []
		kids.each do |kid|
			@kids << kid
		end
		return @kids.as_json(include: :picture_child)
	end

end