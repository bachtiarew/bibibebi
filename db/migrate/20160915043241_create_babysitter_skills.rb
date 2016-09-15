class CreateBabysitterSkills < ActiveRecord::Migration
  def change
    create_table :babysitter_skills , id: false do |t|
      t.belongs_to :babysitter, index: true
      t.belongs_to :skill, index:  true
    end
  end
end
