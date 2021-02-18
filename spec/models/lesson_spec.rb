require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { is_expected.to validate_presence_of(:date_at) }
  it { is_expected.to validate_presence_of(:home_task) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to allow_value('2021/04/21').for(:date_at)}

end
