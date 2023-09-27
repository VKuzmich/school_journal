# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  birthday   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  grade_id   :bigint           not null
#  parent_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_students_on_grade_id   (grade_id)
#  index_students_on_parent_id  (parent_id)
#  index_students_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (grade_id => grades.id)
#  fk_rails_...  (parent_id => parents.id)
#  fk_rails_...  (user_id => users.id)
#
class Student < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  belongs_to :parent

  delegate :email, :full_name, :address, to: :user
  delegate :grade_group, to: :grade
  validates :birthday, presence: true
end
