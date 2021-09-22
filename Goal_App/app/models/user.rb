class User < ApplicationRecord
    attr_reader :password

    validates :username, :password_digest, presence: true
    validates :password, length: {minimum: 6}
    validates :username, uniqueness:true


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        pass_object = BCrypt::Password.new(self.password_digest)
        pass_object.is_password?(password)
    end
  
end
