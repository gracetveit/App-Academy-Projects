# == Schema Information
#
# Table name: users
#
#  id         :integer(8)      not null, primary key
#  email      :string          not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ApplicationRecord
end