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
end