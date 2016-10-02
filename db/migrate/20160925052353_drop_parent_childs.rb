class DropParentChilds < ActiveRecord::Migration
  def change
  	drop_table :parent_childs
  end
end
