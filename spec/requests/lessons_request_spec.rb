require 'rails_helper'

RSpec.describe "Lessons", type: :request do
  let(:lesson) { create(:lesson) }
  let(:lessons) { create_list(:lesson, 3) }
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:not_user) { nil }
  let!(:invalid_id) { '998' }
  let(:no_teacher) { nil }
  let(:new_user) {create(:user)}

  describe 'GET #index' do
    before(:each) do
      sign_in current_user # how to make sign_in for teacher?
      get lessons_path
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }
      it 'index status' do
        expect(response).to have_http_status(:success)
      end
      it 'render index view' do
        is_expected.to render_template :index
      end
    end

    context 'with logged-in user' do
      let(:current_user) { user }
      it 'index status' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      let(:current_user) { :not_user }
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'GET #show' do
    before(:each) do
      sign_in current_user
      get lesson_path(id: lesson.id)
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher }
      it 'show status' do
        expect(response).to have_http_status(:success)
      end
      it 'should show teacher' do
        is_expected.to render_template :show
      end
    end

    context 'not teacher' do
      let(:current_user) { teacher }
      it { expect { get lesson_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'with logged-in user' do
      let(:current_user) { user }
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      let(:current_user) {:not_user}
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end
end
