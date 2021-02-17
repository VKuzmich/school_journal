require 'rails_helper'

RSpec.describe Grade, type: :model do
  it { should validate_presence_of(:number) }
  it { should validate_inclusion_of(:number).in_range(1..12) }
end
