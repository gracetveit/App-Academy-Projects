# == Schema Information
#
# Table name: users
#
#  id         :integer(8)      not null, primary key
#  username   :string          not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ApplicationRecord
    validates :username, presence: true
    validates :username, uniqueness: true

    has_many :artworks,
        dependent: :destroy,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :Artwork

    has_many :comments,
        dependent: :destroy,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Comment

    has_many :artwork_shares,
        dependent: :destroy,
        primary_key: :id,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare

    has_many :shared_artworks,
        through: :artwork_shares,
        source: :shared_artworks
end