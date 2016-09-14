class babysitter_has_skill < ActiveRecord::Base
  belongs_to :babysitter
  belongs_to :skill
end
