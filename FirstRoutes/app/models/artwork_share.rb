# == Schema Information
#
# Table name: artwork_shares
#
#  id         :integer(8)      not null, primary key
#  artwork_id :integer(4)      not null
#  viewer_id  :integer(4)      not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class ArtworkShare < ApplicationRecord
    validates :artwork_id, presence:true
    validates :viewer_id, presence:true
    validate :unique_id_share

    def unique_id_share
        if !ArtworkShare.all.
            where("artwork_id = ? and viewer_id = ?",
                self.artwork_id,
                self.viewer_id
        ).empty?
            errors.add("This artwork has already been shared to this user")
        end
    end

    belongs_to :shared_viewers,
        primary_key: :id,
        foreign_key: :viewer_id,
        class_name: :User

    belongs_to :shared_artworks,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: :Artwork
end