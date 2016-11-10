class CreateNyobas < ActiveRecord::Migration
  def change
    create_table :nyobas do |t|

      t.timestamps null: false
    end
  end
end
