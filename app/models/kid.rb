class Kid < ActiveRecord::Base
	
	validates :name, :gender, :age, :description, presence: true

	belongs_to :parentchild
	
end