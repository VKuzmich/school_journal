# == Schema Information
#
# Table name: teachers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  subject_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_teachers_on_subject_id  (subject_id)
#  index_teachers_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe '#subject_name' do
    let(:subject) { create(:subject) }
    let(:teacher) { create(:teacher, subject: subject) }
    it "returns subject's name" do
      expect(teacher.subject_name).to eq(subject.name)
    end
  end
end
