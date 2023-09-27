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
require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { is_expected.to validate_presence_of(:date_at) }
  it { is_expected.to validate_presence_of(:home_task) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to allow_value('2021/04/21').for(:date_at)}
end
