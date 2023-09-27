# == Schema Information
#
# Table name: grades
#
#  id         :bigint           not null, primary key
#  number     :integer
#  letter     :string(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Grade, type: :model do
  it { should validate_presence_of(:number) }
  it { should validate_inclusion_of(:number).in_range(1..12) }
  it { should validate_presence_of(:letter) }
  it { should validate_length_of(:letter).is_equal_to(1)}
  it { should_not allow_value('d').for(:letter) }
  it { should_not allow_value('SD').for(:letter) }
  it { should_not allow_value('Dc').for(:letter) }
  it { should allow_value('D').for(:letter) }
  it { is_expected.to validate_uniqueness_of(:letter).scoped_to(:number) }

  describe '#grade_group' do
    it "has full title" do
      title = create(:grade, number: "5", letter: "D")
      expect(title.grade_group).to eq("5-D")
    end
  end
end
