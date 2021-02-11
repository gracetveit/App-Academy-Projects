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
    validates :password_digest, presence: true
    validates :session_token, presence: true
    validates :session_token, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }

    after_initialize do
        if self.session_token == nil
            self.session_token = User.generate_session_token
        end
    end

    def self.generate_session_token
        token = SecureRandom.urlsafe_base64
        if User.where(session_token: token).exists?
            User.genenerate_session_token
        end
        token
    end

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
    end

    def password=(pw)
        @password = pw
        self.password_digest = BCrypt::Password.create(pw)
    end
end
