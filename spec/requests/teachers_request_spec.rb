require 'rails_helper'

RSpec.describe "Teachers", type: :request do
  let(:teacher) { create(:teacher) }
  let(:teachers) { create(:teacher, 3) }
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:not_user) { nil }
  let!(:invalid_id) { '998' }
  let(:not_teacher) { nil }
  let(:new_user) {create(:user)}
  let(:new_subject) {create(:subject)}

  describe 'GET #index' do
    context 'with logged-in admin' do
      before do
        sign_in admin
        get admin_teachers_path
      end
      it 'index status' do
        expect(response).to have_http_status(:success)
      end
      it 'render index view' do
        is_expected.to render_template :index
      end
    end

    context 'with logged-in user' do
      before do
        sign_in user
        get admin_teachers_path
      end
      it 'index status' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      before do
        sign_in :not_user
        get admin_teachers_path
      end
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'GET #show' do
    context 'with logged-in admin' do
      before do
        sign_in admin
        get admin_teacher_path(id: teacher.id)
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
        it { expect { get admin_teacher_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end

    context 'with logged-in user' do
      before do
        sign_in user
        get admin_teacher_path(id: teacher.id)
      end
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      before do
        sign_in :not_user
        get admin_teacher_path(id: teacher.id)
      end
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'GET #new' do
    context 'with logged-in admin' do
      before(:each) do
        sign_in admin
        get new_admin_teacher_path
      end
      it 'create a new Teacher' do
        expect(assigns(:teacher)).to be_a_new(Teacher)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    context 'with logged-in user' do
      before do
        sign_in user
        get new_admin_teacher_path
      end
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      before do
        sign_in :not_user
        get new_admin_teacher_path
      end
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'CREATE #create' do
    context 'with logged-in admin' do
      context 'with valid data' do
        let(:user) {create(:user)}
        let(:subject) {create(:subject)}
        before do
          sign_in admin
        end

        it 'redirects to the new teacher' do
          expect(post admin_teachers_path, params: { teacher: { user_id: user.id,
                                                                subject_id: subject.id } })
            .to redirect_to admin_teachers_path
        end

        it { expect do
          post admin_teachers_path, params: { teacher: { user_id: user.id, subject_id: subject.id } }
        end.to change(Teacher, :count).by(1) }
      end

      context 'with invalid attributes' do
        before do
          sign_in admin
          post admin_teachers_path, params: { teacher: { teacher_id: '' } }
        end

        it 'does not save the new teacher' do
          expect { response }.to_not change(Teacher, :count)
        end
        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    context 'with logged-in user' do
      context 'with valid data' do
        before do
          sign_in user
          post admin_teachers_path, params: { teacher: { teacher_id: teacher.id } }
        end
        it 'redirects to root-path' do
          expect(response).to redirect_to root_path
        end
      end
    end

    context "not logged-in user" do
      context 'with valid data' do
        before do
          sign_in :not_user
          post admin_teachers_path, params: { teacher: { teacher_id: teacher.id } }
        end
        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to new_user_session_path }
      end
    end
  end


  describe 'PATCH #update' do
    context 'with logged-in admin' do
      let(:updated_user) {create(:user)}
      let(:updated_subject) {create(:subject)}
      before do
        sign_in admin
        patch admin_teacher_path(id: teacher.id), params: { teacher: { user_id: updated_user.id,
                                                                       subject_id: updated_subject.id } }
        teacher.reload
      end

      context 'valid attributes' do
        it { expect(response).to redirect_to admin_teacher_url }
        it { expect(teacher.subject.name).to be_present }
      end

      context 'with invalid attributes' do
        before do
          sign_in admin
          patch admin_teacher_path(id: teacher.id), params: { teacher: { user_id: '',
                                                                         subject_id: updated_subject.id } }
          teacher.reload
        end
        it 'does not change the subject\'s attributes' do
          expect(response).not_to be_redirect
        end

        it 're-renders the edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'with logged-in user' do
      before do
        sign_in user
        patch admin_teacher_path(id: teacher.id), params: { teacher: { user_id: new_user.id,
                                                                       subject_id: new_subject.id } }
        teacher.reload
      end
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      before do
        sign_in :not_user
        patch admin_teacher_path(id: teacher.id), params: { teacher: { user_id: new_user.id,
                                                                       subject_id: new_subject.id } }
        teacher.reload
      end
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'DELETE #destroy' do
    context 'with logged-in admin' do
      let!(:new_teacher) { create :teacher }
      context 'delete from teachers table' do
        before do
          sign_in admin
          delete admin_teacher_path(id: teacher.id)
        end

        it 'delete teacher' do
          expect { new_teacher.destroy }.to change { Teacher.count }.by(-1)
        end

        it 'redirect to index new after destroy' do
          is_expected.to redirect_to admin_teachers_path
        end
      end
    end

    context 'with logged-in user' do
      before do
        sign_in user
        delete admin_teacher_path(id: teacher.id)
      end
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      before do
        sign_in :not_user
        delete admin_teacher_path(id: teacher.id)
      end
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end
end
