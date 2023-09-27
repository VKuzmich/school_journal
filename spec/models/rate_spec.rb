# == Schema Information
#
# Table name: rates
#
#  id         :bigint           not null, primary key
#  rate       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lesson_id  :bigint           not null
#  student_id :bigint           not null
#
# Indexes
#
#  index_rates_on_lesson_id   (lesson_id)
#  index_rates_on_student_id  (student_id)
#
# Foreign Keys
#
#  fk_rails_...  (lesson_id => lessons.id)
#  fk_rails_...  (student_id => students.id)
#
require 'rails_helper'

RSpec.describe Rate, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
