class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :guest, null: false, index: true
      t.references :hotel, null: false, index: true

      t.text :content, null: false, default: ''

      t.index %i[guest_id hotel_id]
      t.timestamps
    end
  end
end
