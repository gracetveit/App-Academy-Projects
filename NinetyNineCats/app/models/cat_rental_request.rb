# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer(8)      not null, primary key
#  cat_id     :integer(4)      not null
#  start_date :date            not null
#  end_date   :date            not null
#  status     :string          default("PENDING"), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class CatRentalRequest < ApplicationRecord
    validates :cat_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :status, presence: true
    validates :status, inclusion: {
        in: [
            "PENDING",
            "APPROVED",
            "DENIED"
        ]
    }

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat
end