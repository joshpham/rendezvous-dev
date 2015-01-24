class AddStopCode < ActiveRecord::Migration
  def change
		  add_column :phone_numbers, :stop_code, :string  
  end
end
