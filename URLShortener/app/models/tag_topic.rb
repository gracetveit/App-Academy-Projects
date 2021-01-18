# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer(8)      not null, primary key
#  topic      :string          not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class TagTopic < ApplicationRecord
    validates :topic, presence: true
    validates :topic, uniqueness: true

    has_many :taggings,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :Tagging

    has_many :shortened_urls,
        through: :taggings,
        source: :shortened_urls
    
    def popular_links
        sorted = self.shortened_urls.sort  do |a, b| 
            b.num_clicks <=> a.num_clicks
        end
        sorted[0..4].map {|e| [e.long_url, e.num_clicks]}
    end
end