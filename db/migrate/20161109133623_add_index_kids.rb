class AddIndexKids < ActiveRecord::Migration
  def change
  	drop_table :kids
  end
end

