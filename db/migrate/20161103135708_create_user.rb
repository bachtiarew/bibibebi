class CreateUser < ActiveRecord::Migration
 def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.string :phone_number
      t.string :bornplace
      t.date :borndate
      t.text :address

      t.timestamps
    end
  end
end
