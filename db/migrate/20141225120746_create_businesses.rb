class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name
      t.references :user, index: true
      t.string :slug

      t.timestamps
    end
  end
end
