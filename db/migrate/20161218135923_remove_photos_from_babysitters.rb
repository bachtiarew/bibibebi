class RemovePhotosFromBabysitters < ActiveRecord::Migration
  def change
  	remove_column :babysitters, :photos, :string
  end
end
