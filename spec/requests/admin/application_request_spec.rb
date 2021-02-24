require 'rails_helper'

RSpec.describe "Admin::Applications", type: :request do
  # include 'support/devise.rb'
  describe '#authorized?' do
    let(:user) { {email: "test@test.com", password: "123456" }}
    let(:user_admin) { { email: "tost@tost.com", password: "12345678" } }

    describe 'authorized admin user' do

      it 'returns http success' do
        sign_in :user_admin
        # get :index
        # expect(response).to have_http_status(:success)
      end
    end
  end
end
