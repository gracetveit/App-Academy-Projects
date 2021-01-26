class AddIndexToTitleInArtworks < ActiveRecord::Migration[6.1]
  def change
    add_index :artworks, :title, { unique: true }
  end
end
