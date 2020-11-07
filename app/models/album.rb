class Album < ApplicationRecord
    has_and_belongs_to_many :users, as: :collectable

    has_and_belongs_to_many :songs

    has_many :favourites
end
