class CreateTableParentChilds < ActiveRecord::Migration
  def change
    create_table :parent_childs do |t|
    	t.string :photo
    	t.references :user

    	t.timestamps
    end
    
    add_index :parent_childs, :user_id 
  end
end
