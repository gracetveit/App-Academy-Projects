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
    validate :no_spamming
    validate :nonpremium_max

    def no_spamming
        recent_urls = ShortenedUrl.all.where('created_at > ?', 5.minutes.ago)
        recent_users = recent_urls.map { |e| e.user_id }
        test = recent_users.count(self.user_id) >= 5
        if test
            errors.add(:user_id, "Can't upload more than 5 links in 5 minutes")
        end
    end

    def nonpremium_max
        count = self.submitter.submitted_urls.count
        premium = self.submitter.premium
        if !premium && count >= 5
            errors.add(:user_id, "Is not premium, and cannot add more than 5 links")
        end
    end

    belongs_to(:submitter, {
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
    })

    has_many(:visits, {
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Visit
    })

    has_many(:taggings, {
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :Tagging
    })

    has_many :visitors,
        -> {distinct},
        through: :visits,
        source: :visitors

    has_many :tag_topics, 
        through: :taggings,
        source: :tag_topics

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
        ).save!
        ShortenedUrl.where(short_url: short_url)[0]
    end

    def num_clicks
        self.visits.count
    end

    def num_uniques
        self.visitors.count
    end

    def num_recent_uniques
        self.visitors.where('visits.created_at > ?', 10.minutes.ago).count
    end
end