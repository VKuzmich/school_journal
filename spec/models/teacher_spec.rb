require 'rails_helper'

RSpec.describe Teacher, type: :model do
  describe '' do
    it '#subject_name' do
      subject = create(:subject)
      allow_any_instance_of(Teacher).to receive(:subject_name).and_return(subject.name)

      teacher = create(:teacher)
      expect(teacher.subject_name).to eq(subject.name)
    end
  end
end
