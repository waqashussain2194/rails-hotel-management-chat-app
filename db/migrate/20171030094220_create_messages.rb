class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :guest, null: false, index: true
      t.references :hotel, null: false, index: true

      t.text :content, null: false, default: ''

      t.index %i[guest_id hotel_id]
      t.timestamps
    end
  end
end
