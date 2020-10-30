class CreateUsersAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums_users do |t|
      t.references :album, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
