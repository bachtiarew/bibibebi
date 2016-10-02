class RenameChilds < ActiveRecord::Migration
  def change
  	rename_table :childs, :kids
  end
end
