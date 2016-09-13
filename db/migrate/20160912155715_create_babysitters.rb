class CreateBabysitters < ActiveRecord::Migration
  def change
    create_table :babysitters do |t|
    	t.string :nik
    	t.string :age
    	t.text	:description
    	t.references :user

      t.timestamps
    end

    add_index :babysitters, :user_id
  end
end
