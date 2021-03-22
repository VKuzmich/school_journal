require 'rails_helper'

RSpec.describe "Admin::Students", type: :request do
  let(:student) { create(:student) }
  let(:students) { create_list(:student, 3) }
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:not_user) { nil }
  let!(:invalid_id) { '998' }
  let(:now_student) { nil }
  let(:new_user) {create(:user)}

  describe 'GET #index' do
    before(:each) do
      sign_in current_user
      get admin_students_path
    end

    context 'with logged-in admin' do
      let(:current_user) {admin}
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
      get admin_student_path(id: student.id)
    end

    context 'with logged-in admin' do
      let(:current_user) { admin }
      it 'show status' do
        expect(response).to have_http_status(:success)
      end
      it 'should show student' do
        is_expected.to render_template :show
      end
    end

    context 'does not exist student' do
      let(:current_user) { admin }
      it { expect { get admin_student_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }
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

  describe 'GET #new' do
    before(:each) do
      sign_in current_user
      get new_admin_student_path
    end

    context 'with logged-in admin' do
      let(:current_user) {admin}
      it 'create a new Student' do
        expect(assigns(:student)).to be_a_new(Student)
      end
      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    context 'with logged-in user' do
      let(:current_user) {user}
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      let(:current_user) { :not_user }
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'CREATE #create' do
    context 'with logged-in admin' do
      context 'with valid data' do
        let(:user) {create(:user)}
        let(:grade) {create(:grade)}
        let(:parent) {create(:parent)}
        let(:student) {create(:student)}
        before do
          sign_in admin
        end

        it { expect do
          post admin_students_path, params: { student: { user_id: user.id,
                                                         grade_id: grade.id,
                                                         parent_id: parent.id,
                                                         birthday: Faker::Date.birthday } }
        end.to change(Student, :count).by(1) }

        it 'redirects to the new student' do
          expect(post admin_students_path, params: { student:
                                                       { user_id: user.id,
                                                         grade_id: grade.id,
                                                         parent_id: parent.id,
                                                         birthday: Faker::Date.birthday
          } })
            .to redirect_to admin_students_path
        end
      end

      context 'with invalid attributes' do
        before do
          sign_in admin
          post admin_students_path, params: { student: { student_id: '' } }
        end

        it 'does not save the new student' do
          expect { response }.to_not change(Student, :count)
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
          post admin_students_path, params: { student: { student_id: student.id } }
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
          post admin_students_path, params: { student: { student_id: student.id } }
        end
        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to new_user_session_path }
      end
    end
  end


  describe 'PATCH #update' do
    before(:each) do
      sign_in current_user
      patch admin_student_path(id: student.id), params: { student: { user_id: current_param } }
      student.reload
    end

    context 'with logged-in admin' do
      let(:updated_user) {create(:user)}
      let(:current_user) { admin }
      let(:current_param) { updated_user.id }

      context 'valid attributes' do
        it { expect(response).to redirect_to admin_student_url }
        it { expect(student.full_name).to be_present }
      end

      context 'with invalid attributes' do
        let(:current_param) { '' }

        it 'does not change the student\'s attributes' do
          expect(response).not_to be_redirect
        end

        it 're-renders the edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'with logged-in user' do
      let(:current_user) { user }
      let(:current_param) { new_user.id }

      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      let(:current_user) { :not_user }
      let(:current_param) { new_user.id }
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in current_user
      delete admin_student_path(id: student.id)
    end

    context 'with logged-in admin' do
      let!(:new_student) { create :student }

      context 'delete from students table' do
        let(:current_user) { admin }

        it 'delete student' do
          expect { new_student.destroy }.to change { Student.count }.by(-1)
        end

        it 'redirect to index new after destroy' do
          is_expected.to redirect_to admin_students_path
        end
      end
    end

    context 'with logged-in user' do
      let(:current_user) { user }
      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end

    context "not logged-in user" do
      let(:current_user) { :not_user }
      it { expect(response.status).to eq(302) }
      it { expect(response).to redirect_to new_user_session_path }
    end
  end
end
