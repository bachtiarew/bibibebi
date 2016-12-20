class RenameColumnPictures < ActiveRecord::Migration
  def change
  	change_table :pictures do |t|
  		t.rename :picturable_id, :pictureable_id
  	end
  end
end
