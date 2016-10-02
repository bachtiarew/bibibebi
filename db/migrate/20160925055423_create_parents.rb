class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|	
    	t.string :photo
    	t.references :user

    	t.timestamps
    end

    add_index :parents, :user_id
  end
end
