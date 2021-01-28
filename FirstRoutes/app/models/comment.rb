# == Schema Information
#
# Table name: comments
#
#  id         :integer(8)      not null, primary key
#  body       :string          not null
#  user_id    :integer(4)      not null
#  artwork_id :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Comment < ApplicationRecord
    validates :body, presence:true
    validates :user_id, presence:true
    validates :artwork_id, presence:true

    belongs_to :author,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :artwork,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: :Artwork
end