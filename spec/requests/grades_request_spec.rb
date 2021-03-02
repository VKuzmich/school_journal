require 'rails_helper'

RSpec.describe "Admin::Grades", type: :request do
    let(:grade) { create(:grade) }
    let(:grades) { create_list(:grade, 3) }
    let!(:admin) { create(:user, :admin) }
    let!(:user) { create(:user) }
    let(:attr) { { number: '5' , letter: "D" } }
    let(:wrong_attr) { { number: '5' , letter: "" } }
    let(:invalid_id) { '998' }

    describe 'GET #index' do
      context 'with logged-in admin' do
        before(:each) do
          sign_in admin
          get admin_grades_path
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
          get root_path
        end
        it 'index status' do
          expect(response).to render_template :index
        end
      end

      context "not logged-in user" do
        before do
          sign_out user
          get root_path
        end
        it 'should get status 200' do
          expect(response).to have_http_status(200)
        end
      end
    end

    describe 'GET #show' do
      before do
        sign_in admin
        get admin_grade_path(id: grade.id)
      end
      it 'show status' do
        expect(response).to have_http_status(:success)
      end
      it 'should show grade' do
        is_expected.to render_template :show
      end

      context 'does not exist grade' do
        it { expect { get admin_grade_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }

      end
    end

    describe 'DELETE #destroy' do
      let!(:new_grade) { create :grade }
      context 'delete from subjects table' do
        before do
          sign_in admin
          delete admin_grade_path(id: grade.id)
        end

        it 'delete grade' do
          expect { new_grade.destroy }.to change { Grade.count }.by(-1)
        end

        it 'redirect to index new after destroy' do
          is_expected.to redirect_to admin_grades_path
        end
      end
    end

    describe 'GET #new' do
      before(:each) do
        sign_in admin
      end
      it 'create a new Grade' do
        get new_admin_grade_path
        expect(assigns(:grade)).to be_a_new(Grade)
      end
      it 'renders the :new template' do
        get new_admin_grade_path
        expect(response).to render_template :new
      end
    end

    describe 'CREATE #create' do
      before do
        sign_in admin
      end
      context 'with valid data' do
        before do
          post admin_grades_path, params: { grade: { number: '8', letter: "C" } }
        end

        it 'redirects to the new grades' do
          expect(response).to redirect_to admin_grades_path
        end
        it 'name of created and saved Grade' do
          subject = Grade.last
          expect(subject.number).to eq( 8)
          expect(subject.letter).to eq( "C" )
        end
        it { expect(Grade.count).to eq(1) }
      end

      context 'with invalid attributes' do
        before do
          post admin_grades_path, params: { grade: { letter: '' } }
        end

        it 'does not save the new grade' do
          expect { response }.to_not change(Grade, :count)
        end
        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      before(:each) do
        sign_in admin
        patch admin_grade_path(id: grade.id), params: { id: grade.id, grade: attr }
        grade.reload
      end

      context 'valid attributes' do
        it { expect(response).to redirect_to admin_grade_url }
        it { expect(grade.number).to eq(5) }
        it { expect(response).to be_redirect }
      end

      context 'with invalid attributes' do
        before do
          patch admin_grade_path(id: grade.id), params: { id: grade.id, grade: wrong_attr }
          grade.reload
        end
        it 'does not change the grade\'s attributes' do
          expect(response).not_to be_redirect
        end

        it 're-renders the edit template' do
          expect(response).to render_template :edit
        end
      end
    end
end
