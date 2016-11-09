class RenameIndexKids < ActiveRecord::Migration
  def change
  	rename_table :parentchilds , :ortus
  end
end

