# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer(8)      not null, primary key
#  long_url   :string          not null
#  short_url  :string          not null
#  user_id    :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ShortenedUrl < ApplicationRecord
    validates :long_url, presence: true
    validates :short_url, presence: true
    validates :short_url, uniqueness: true
    validates :user_id, presence: true

    belongs_to(:submitter, {
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    })

    def self.random_code
        code = SecureRandom.urlsafe_base64
        while ShortenedUrl.exists?(short_url: code)
            code = SecureRandom.urlsafe_base64
        end
        code
    end

    def self.create!(user, long_url)
        short_url = ShortenedUrl.random_code
        ShortenedUrl.new(
            long_url: long_url,
            short_url: short_url,
            user_id: user.id
        ).save
    end
end