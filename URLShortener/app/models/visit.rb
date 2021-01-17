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
end