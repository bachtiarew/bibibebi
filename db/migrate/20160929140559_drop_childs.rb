class DropChilds < ActiveRecord::Migration
  def change
  	drop_table :childs
  end
end
