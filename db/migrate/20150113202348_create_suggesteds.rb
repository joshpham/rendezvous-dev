class CreateSuggesteds < ActiveRecord::Migration
  def change
    create_table :suggesteds do |t|
      t.string :name

      t.timestamps
    end
  end
end
