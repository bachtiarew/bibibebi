class AddPhoneNumber < ActiveRecord::Migration
  def change
  	add_column :users, :phone_number, :integer
  end
end
