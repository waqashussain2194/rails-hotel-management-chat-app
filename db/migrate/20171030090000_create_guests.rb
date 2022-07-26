class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.json :profile, null: false, default: {}
      t.string :external_id, null: false

      t.index :external_id, unique: true
      t.timestamps
    end
  end
end
