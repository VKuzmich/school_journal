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
require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:birthday) }
  end
end
