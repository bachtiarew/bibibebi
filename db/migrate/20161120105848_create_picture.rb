class CreatePicture < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.string	:picture_url
    	t.integer	:picturable_id
    	t.string	:pictureable_type
    	t.timestamps
    end
  end
end
