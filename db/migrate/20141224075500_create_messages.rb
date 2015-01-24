class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message
      t.datetime :sent_on
      t.references :phone_list, index: true

      t.timestamps
    end
  end
end

