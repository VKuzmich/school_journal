# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone                  :string(17)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:phone) }

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

  describe '#full_name' do
    it "has a full name" do
      person = create(:user, first_name: "Svenson", last_name: "Fiord")
      expect(person.full_name).to eq("Svenson Fiord")
    end
  end
end
