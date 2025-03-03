class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true
      t.datetime :start_datetime
      t.datetime :end_datetime
      t.integer :guests
      t.integer :status, default: 1, null: false

      t.timestamps
    end
  end
end
