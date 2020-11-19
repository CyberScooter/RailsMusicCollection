class Contact
    include ActiveModel::Model
    #for validation
    include ActiveModel::Validations

    attr_accessor :name, :email, :message
    validates :name, :email, :message, presence: true

    #regex expression to validate email is in correct format
    validates_format_of :email, 
    :with => /\A[\w.+-]+@\w+\.\w+\z/
end
