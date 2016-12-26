class AddPriceToBabysitters < ActiveRecord::Migration
  def change
  	add_column :babysitters, :price, :decimal, precision: 5, scale: 2
  end
end
