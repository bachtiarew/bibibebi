class RenameParents < ActiveRecord::Migration
  def change
  	rename_table :parents , :parentchilds
  end
end

