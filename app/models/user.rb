class User < ApplicationRecord

    ##creates a many-to-many relationship
    has_and_belongs_to_many :albums

    has_secure_password

end
