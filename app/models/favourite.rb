class Favourite < ApplicationRecord
  self.table_name = "favourites"
  belongs_to :album, required: false
  belongs_to :user, required: false

end
