class Song < ApplicationRecord
    validates :name, :artist, :year, presence: true

    has_and_belongs_to_many :albums

end
