require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it '#subject_name' do
    subject = create(:subject, name: "Physics")
    expect(subject.name).to eq('Physics')
  end
end
