class AddVerificationPhoneBoolean < ActiveRecord::Migration
  def change
		  add_column :phone_numbers, :verification_code, :string
    add_column :phone_numbers, :verified, :boolean, :default => false, :null => false       
  end
end
