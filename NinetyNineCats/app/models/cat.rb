# == Schema Information
#
# Table name: cats
#
#  id          :integer(8)      not null, primary key
#  birth_date  :date            not null
#  color       :string          not null
#  name        :string          not null
#  sex         :string          not null
#  description :text            not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Cat < ApplicationRecord
    validates :birth_date, presence: true
    validates :color, presence: true
    validates :name, presence: true
    validates :sex, presence: true
    validates :description, presence: true
end