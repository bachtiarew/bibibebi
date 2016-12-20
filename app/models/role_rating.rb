class RoleRating < ActiveRecord::Base
	self.table_name = "rating_caches"
	belongs_to :cacheable, polymorphic: true
end
