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

    belongs_to(:user, {
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    })
end