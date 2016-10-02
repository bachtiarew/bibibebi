class CreateParentchilds < ActiveRecord::Migration
  def change
    create_table :parentchilds do |t|
    	t.string :photo
    	t.references :user
    	
    	t.timestamps
    end

    add_index :parentchilds, :user_id
  end
end
