class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :role
      t.string :firstname
      t.string :lastname
      t.string :bornplace
      t.date :borndate
      t.text :address

      t.timestamps
    end
  end
end
