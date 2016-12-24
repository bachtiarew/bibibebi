class Kid < ActiveRecord::Base
	
	validates :name, :gender, :age, :description, presence: true
	belongs_to :ortu
	has_many :pictures, as: :pictureable
	
	attr_accessor :picture_child


	def picture_child
		Picture.where(pictureable_id: self.id, pictureable_type: "Kid")
	end	
end