class CreateCheckIns < ActiveRecord::Migration[5.1]
  def change
    create_table :check_ins do |t|
      t.references :guest, null: false, index: true
      t.references :hotel, null: false, index: true

      t.datetime :checked_out_at

      t.index %i[guest_id hotel_id]
      t.timestamps
    end
  end
end
