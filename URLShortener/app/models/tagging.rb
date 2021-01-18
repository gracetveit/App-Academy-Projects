# == Schema Information
#
# Table name: taggings
#
#  id               :integer(8)      not null, primary key
#  tag_topic_id     :integer(4)      not null
#  shortened_url_id :integer(4)      not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#

class Tagging < ApplicationRecord
    validates :tag_topic_id, presence: true
    validates :shortened_url_id, presence: true

    belongs_to :tag_topics,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :TagTopic

    belongs_to :shortened_urls,
        primary_key: :id,
        foreign_key: :shortened_url_id,
        class_name: :ShortenedUrl
end