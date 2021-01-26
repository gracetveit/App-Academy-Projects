# == Schema Information
#
# Table name: artworks
#
#  id         :integer(8)      not null, primary key
#  title      :string          not null
#  image_url  :string          not null
#  artist_id  :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true
    validates :image_url, uniqueness: true
    validates :artist_id, presence: true
    validate :unique_id_title

    def unique_id_title
        if !User.all.
            joins(:artworks).
            where("title = ? and users.id = ?",
                self.title,
                self.artist_id
            ).empty?
                errors.add(:title, "Is already used by the artist")
        end
    end

    belongs_to :artist,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :User
end