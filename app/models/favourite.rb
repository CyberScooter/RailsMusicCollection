class Favourite < ApplicationRecord



  
  # self.table_name = "favourites"
  belongs_to :album
  belongs_to :user

end
