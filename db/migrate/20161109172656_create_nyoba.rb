class CreateNyoba < ActiveRecord::Migration
  def change
    create_table :nyobas do |t|
    	t.string :product_name
    	t.integer :qty
    	t.integer :price

    	t.timestamps
    end
  end
end
