# == Schema Information
#
# Table name: enrollments
#
#  id         :integer(8)      not null, primary key
#  course_id  :integer
#  student_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Enrollment < ApplicationRecord
end