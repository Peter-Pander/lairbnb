class AddEmbeddingToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :embedding, :vector, limit: 1536
  end
end
