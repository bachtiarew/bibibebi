class SkillSerializer < ApplicationSerializer
	attributes(
		:id,
		:name,
		:description,
		:score
	)
end