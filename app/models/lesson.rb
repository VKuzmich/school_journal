# == Schema Information
#
# Table name: lessons
#
#  id          :bigint           not null, primary key
#  date_at     :date
#  description :string
#  home_task   :string
#  number      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  grade_id    :bigint           not null
#  subject_id  :bigint           not null
#  teacher_id  :bigint           not null
#
# Indexes
#
#  index_lessons_on_grade_id    (grade_id)
#  index_lessons_on_subject_id  (subject_id)
#  index_lessons_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (grade_id => grades.id)
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class Lesson < ApplicationRecord
  START_NUMBER = 1
  END_NUMBER = 9

  belongs_to :subject
  belongs_to :grade
  belongs_to :teacher

  has_many :rates

  validates :date_at, :home_task, :description, :number, presence: true
  validates :number, inclusion: START_NUMBER..END_NUMBER
end
