class AddStartCode < ActiveRecord::Migration
  def change
		  add_column :phone_numbers, :start_code, :string  
  end
end
