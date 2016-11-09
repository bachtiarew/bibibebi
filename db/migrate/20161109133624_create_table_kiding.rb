class CreateTableKiding < ActiveRecord::Migration
  def change
  	create_table :kids do |t|
	  	t.string   :name        
	    t.string   :gender      
	    t.integer  :age         
	    t.text     :description 
	    t.integer  :parent_id
	    
	    t.timestamps
  	end
  	add_index :kids, :ortu_id
  end
end

