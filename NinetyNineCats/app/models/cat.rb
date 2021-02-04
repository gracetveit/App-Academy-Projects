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
    validates :color, inclusion: {in: [
        "Tabby",
        "Calico",
        "Black",
        "White"
    ], message: "%{value} is not a valid color"}
    validates :name, presence: true
    validates :sex, presence: true
    validates :sex, inclusion: {in: %w(M F),
        message: "%{value} is not a valid sex"}
    validates :description, presence: true
    
    has_many :rental_requests,
        dependent: :detroy,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :CatRentalRequest

    def age
        age = Date.today - self.birth_date
        age.round / 365
    end
end