class RenameColumnParents < ActiveRecord::Migration
  def change
  	change_table :parents do |t|
  		t.rename :photo, :photos
  	end
  end
end
