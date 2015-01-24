class CreatePhoneLists < ActiveRecord::Migration
  def change
    create_table :phone_lists do |t|
      t.references :business, index: true
      t.string :name

      t.timestamps
    end
  end
end
