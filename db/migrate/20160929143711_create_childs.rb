class CreateChilds < ActiveRecord::Migration
  def change
    create_table :childs do |t|
    	t.string :name
    	t.string :gender
    	t.integer :age
    	t.text :description
    	t.references :parent
    	t.timestamps
    end
    add_index :childs, :parent_id
  end
end
