class CreateAlbumsSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :albums_songs do |t|
      t.references :album, foreign_key: true
      t.references :song, foreign_key: true
    end
  end
end
