class AddBusinessCityState < ActiveRecord::Migration
  def change
    add_column :businesses, :city, :string
    add_column :businesses, :state, :string
    add_column :businesses, :address1, :string
    add_column :businesses, :address2, :string
    add_column :businesses, :zip, :string
    add_column :businesses, :hours, :string
    add_column :businesses, :description, :string
  end
end
