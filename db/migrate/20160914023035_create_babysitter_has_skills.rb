class CreateBabysitterHasSkills < ActiveRecord::Migration
  def change
    create_table :babysitter_has_skills do |t|
      t.integer :babysitter_id
      t.integer :skill_id

    end
    add_index :babysitter_has_skills, :babysitter_id
    add_index :babysitter_has_skills, :skill_id
  end
end
