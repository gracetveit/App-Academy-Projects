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
#  user_id    :integer(4)      not null
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
    validates :user_id, presence: true
    validate :does_not_overlap_approved_request, on: :create
    
    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :cat,
        primary_key: :id,
        foreign_key: :cat_id,
        class_name: :Cat

    def approve!
        CatRentalRequest.transaction do
            self.update(status: "APPROVED")
            self.overlapping_pending_requests.each do |request|
                request.update(status: "DENIED")
            end
        end
    end

    def deny!
        CatRentalRequest.transaction do
            self.update(status: "DENIED")
        end
    end
        
    private

    def overlapping_requests
        CatRentalRequest.where(
            cat_id: self.cat_id
        ).where.not(
            id: self.id
        ).where.not(
            "start_date > ?",
            self.end_date
        ).where.not(
            "end_date < ?",
            self.start_date
        ).or(
            CatRentalRequest.where(
                cat_id: self.cat_id
            ).where.not(
                id: self.id
            ).where.not(
                "end_date < ?",
                self.start_date
            ).where.not(
                "start_date > ?",
                self.end_date
            )
        )
    end

    def overlapping_approved_requests
        self.overlapping_requests.where(status: "APPROVED")
    end

    def overlapping_pending_requests
        self.overlapping_requests.where(status: "PENDING")
    end

    def does_not_overlap_approved_request
        if self.overlapping_approved_requests.exists?
            errors.add(:invalid, "cannot overlap with an approved request")
        end
    end
end
