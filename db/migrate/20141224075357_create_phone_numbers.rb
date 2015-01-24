class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.references :phone_list, index: true

      t.timestamps
    end
  end
end


