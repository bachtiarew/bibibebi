class AddColumnFromBabysitters < ActiveRecord::Migration
  def change
    add_column :babysitters, :photos, :string
  end
end
