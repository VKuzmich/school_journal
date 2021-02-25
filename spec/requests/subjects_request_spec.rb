require 'rails_helper'

RSpec.describe "Subjects", type: :request do
  let(:subject) { FactoryBot.create(:subject) }
  let(:subjects) { FactoryBot.create_list(:subject, 6) }
  describe 'GET #index' do
    before do
      get subjects_path
    end
    it 'index status' do
      expect(response.status).to eq(200)
    end
    it 'render index view' do
      is_expected.to render_template :index
    end
  end
  describe 'GET #show' do
    before do
      get subject_path(id: subject.id)
    end
    it 'show status' do
      expect(response.status).to eq(200)
    end
    it 'should show subject' do
      is_expected.to render_template :show
    end
  end

  describe 'DELETE #destroy' do
    let!(:new_subject) { FactoryBot.create :subject }
    context 'delete from subjects table' do
      before do
        get subject_path(id: subject.id)
      end
      it 'delete subject' do
        expect { new_subject.destroy }.to change { Subject.count }.by(-1)
      end

      it 'after delete response successful' do
        expect(response).to be_successful
      end

      it 'render view new after destroy' do
        is_expected.to render_template :show
      end
    end
  end
end
