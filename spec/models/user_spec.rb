require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }

    it { should validate_uniqueness_of(:first_name).case_insensitive }
    it { should validate_uniqueness_of(:last_name).case_insensitive }

    it { is_expected.to validate_length_of(:first_name).is_at_least(3).is_at_most(40) }
    it { is_expected.to validate_length_of(:last_name).is_at_least(3).is_at_most(40) }
    it { is_expected.to validate_length_of(:address).is_at_least(3).is_at_most(40) }

    it { is_expected.to allow_value('Lave').for(:first_name) }
    it { is_expected.not_to allow_value('lavan').for(:first_name) }
    it { is_expected.not_to allow_value('La').for(:first_name) }

    it { is_expected.to allow_value('Fenix').for(:last_name) }
    it { is_expected.not_to allow_value('Fe').for(:last_name) }
    it { is_expected.not_to allow_value('fer').for(:last_name) }

    it { is_expected.to allow_value('Dnipro 23').for(:address) }
    it { is_expected.to allow_value('Dnipro 23.').for(:address) }
    it { is_expected.to allow_value('Dnipro 23.!').for(:address) }
    it { is_expected.to allow_value('Dnipro 23.""').for(:address) }
    it { is_expected.not_to allow_value('-Dnipro 23').for(:address) }
    it { is_expected.not_to allow_value('Dk').for(:address) }

    it { is_expected.to allow_value('+38(023)122-2222').for(:phone) }
    it { is_expected.not_to allow_value('+38(023)-122-2222').for(:phone) }
    it { is_expected.not_to allow_value('38(023)-122-2222').for(:phone) }
    it { is_expected.not_to allow_value('+38(23)-122-2222').for(:phone) }
    it { is_expected.not_to allow_value('+38(023)-122-222').for(:phone) }
    it { is_expected.not_to allow_value('+38(023)-12-2222').for(:phone) }
    it { is_expected.not_to allow_value('+38(023)-1222222').for(:phone) }
  end
end
