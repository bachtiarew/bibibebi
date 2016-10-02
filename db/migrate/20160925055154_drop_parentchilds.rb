class DropParentchilds < ActiveRecord::Migration
  def change
  	drop_table :parentchilds
  end
end
