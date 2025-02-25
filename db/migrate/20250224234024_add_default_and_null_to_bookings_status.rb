class AddDefaultAndNullToBookingsStatus < ActiveRecord::Migration[7.1]
  def change
    change_column :bookings, :status, :integer, default: 1, null: false
  end
end
