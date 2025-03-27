class AddTaglineToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :tagline, :string
  end
end
