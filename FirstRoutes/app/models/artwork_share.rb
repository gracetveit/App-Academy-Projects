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
end