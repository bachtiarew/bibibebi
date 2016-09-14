class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
    	t.string :name
    	t.text :description
    	t.integer :score
    	t.integer :babysitter_id
    end

    add_index :skills, :babysitter_id
  end
end
