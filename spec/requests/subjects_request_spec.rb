require 'rails_helper'

RSpec.describe 'Admin::Subjects', type: :request do
  let(:subject) { create(:subject) }
  let(:subjects) { create_list(:subject, 3) }
  let!(:admin) { create(:user, :admin) }
  let(:attr) { { name: 'Physics' } }
  let(:wrong_attr) { { name: '' } }
  let(:invalid_id) { '998' }

  describe 'GET #index' do
    context 'with logged-in admin' do
      before(:each) do
        sign_in admin
        get admin_subjects_path
        it 'index status' do
          expect(response).to have_http_status(:success)
        end
        it 'render index view' do
          is_expected.to render_template :index
        end
      end
    end

    # context 'with logged-in user' do
    #   before(:each) do
    #     sign_in user
    #     get root_path
    #   end
    #   it 'index status' do
    #     expect(page).to have_current_path(root_path)
    #   end
    # end
  end

  describe 'GET #show' do
    before do
      sign_in admin
      get admin_subject_path(id: subject.id)
    end
    it 'show status' do
      expect(response).to have_http_status(:success)
    end
    it 'should show subject' do
      is_expected.to render_template :show
    end

    context 'does not exist subject' do
      before do
        sign_in admin
      end
      it { expect { get admin_subject_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }

    end
  end

  describe 'DELETE #destroy' do
    let!(:new_subject) { create :subject }
    context 'delete from subjects table' do
      before do
        sign_in admin
        delete admin_subject_path(id: subject.id)
      end

      it 'delete subject' do
        expect { new_subject.destroy }.to change { Subject.count }.by(-1)
      end

      it 'redirect to index new after destroy' do
        is_expected.to redirect_to admin_subjects_path
      end
    end
  end

  describe 'GET #new' do
    before(:each) do
      sign_in admin
    end
    it 'create a new Subject' do
      get new_admin_subject_path
      expect(assigns(:subject)).to be_a_new(Subject)
    end
    it 'renders the :new template' do
      get new_admin_subject_path
      expect(response).to render_template :new
    end
  end

  describe 'CREATE #create' do
    context 'with valid data' do
      before do
        sign_in admin
        post admin_subjects_path, params: { subject: { name: 'English' } }
      end

      it 'redirects to the new subject' do
        expect(response).to redirect_to admin_subjects_path
      end
      it 'name of created and saved Subject' do
        subject = Subject.last
        expect(subject.name).to eq( "English")
      end
      it { expect(Subject.count).to eq(1) }
    end

    context 'with invalid attributes' do
      before do
        sign_in admin
        post admin_subjects_path, params: { subject: { name: '' } }
      end

      it 'does not save the new subject' do
        expect { response }.to_not change(Subject, :count)
      end
      it 're-renders the new method' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      sign_in admin
      patch admin_subject_path(id: subject.id), params: { id: subject.id, subject: attr }
      subject.reload
    end

    context 'valid attributes' do
      it { expect(response).to redirect_to admin_subject_url }
      it { expect(subject.name).to eq('Physics') }
      it { expect(response).to be_redirect }
    end

    context 'with invalid attributes' do
      before do
        patch admin_subject_path(id: subject.id), params: { id: subject.id, subject: wrong_attr }
        subject.reload
      end
      it 'does not change the subject\'s attributes' do
        expect(response).not_to be_redirect
      end

      it 're-renders the edit template' do
        expect(response).to render_template :edit
      end
    end
  end
end
