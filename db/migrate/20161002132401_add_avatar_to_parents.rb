class AddAvatarToParents < ActiveRecord::Migration
  def change
    add_column :parents, :photos, :string
  end
end
