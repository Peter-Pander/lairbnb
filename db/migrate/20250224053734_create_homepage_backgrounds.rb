class CreateHomepageBackgrounds < ActiveRecord::Migration[7.1]
  def change
    create_table :homepage_backgrounds do |t|

      t.timestamps
    end
  end
end
