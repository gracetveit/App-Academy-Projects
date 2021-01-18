# == Schema Information
#
# Table name: visits
#
#  id               :integer(8)      not null, primary key
#  num_visits       :integer(4)      not null
#  shortened_url_id :integer(4)      not null
#  user_id          :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Visit < ApplicationRecord
    validates :shortened_url_id, presence: true
    validates :user_id, presence: true

    belongs_to(:visitors, {
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    })

    belongs_to(:visited_urls, {
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl
    })

    def self.record_visit!(user, shortened_url)
        Visit.create!(
            shortened_url_id: shortened_url.id,
            user_id: user.id
        )
    end

    
end