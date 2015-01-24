class AddPhoneActiveAttribute < ActiveRecord::Migration
  def change
		  add_column :phone_numbers, :active, :boolean, :default => true, :null => false  
  end
end
