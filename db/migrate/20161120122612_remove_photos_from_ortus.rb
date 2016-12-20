class RemovePhotosFromOrtus < ActiveRecord::Migration
  def change
  	remove_column :ortus, :photos
  end
end
