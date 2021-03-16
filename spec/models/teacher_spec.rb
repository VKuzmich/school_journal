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
