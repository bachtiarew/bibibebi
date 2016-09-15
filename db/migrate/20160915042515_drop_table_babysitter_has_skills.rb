class DropTableBabysitterHasSkills < ActiveRecord::Migration
  def change
    drop_table :babysitter_has_skills
  end
end
