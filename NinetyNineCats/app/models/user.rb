# == Schema Information
#
# Table name: users
#
#  id              :integer(8)      not null, primary key
#  user_name       :string          not null
#  password_digest :string          not null
#  session_token   :string          not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class User < ApplicationRecord
    validates :user_name, presence: true
    validates :user_name, uniqueness: true
    validates :password_digest, presence: true
    validates :session_token, presence: true
    validates :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }

    has_many :cats,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Cat

    has_many :rental_requests,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :CatRentalRequest

    has_many :requested_cats,
        through: :rental_requests,
        source: :cat

    after_initialize do
        if self.session_token == nil
            self.session_token = User.generate_session_token
        end
    end

    attr_reader :password

    def self.generate_session_token
        token = SecureRandom.urlsafe_base64
        if User.where(session_token: token).exists?
            User.genenerate_session_token
        end
        token
    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        if user == nil || !user.is_password?(password)
            raise "Unable to find user with that username or password"
        end
        user
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
    end

    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end

    def is_password?(pw)
        digest = BCrypt::Password.new(self.password_digest)
        digest.is_password?(pw)
    end
end
