class User < ApplicationRecord
    validates :password, length: {minimum: 8}



    ##creates a many-to-many relationship
    has_and_belongs_to_many :albums
    has_many :favourites

    #bcrypt has_secure_password for storing hashes
    has_secure_password

end
