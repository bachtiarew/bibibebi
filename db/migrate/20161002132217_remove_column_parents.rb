class RemoveColumnParents < ActiveRecord::Migration
  def change
  	remove_column :parents, :photos, :string
  end
end
