require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validation' do
    it { is_expected.to validate_presence_of(:birthday) }
  end
end
