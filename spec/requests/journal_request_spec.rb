require 'rails_helper'

RSpec.describe "Journals", type: :request do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:teacher) { create(:teacher) }
    let(:parent) { create(:parent) }
    let!(:student) { create(:student, grade: grade) }
    let!(:grade) { create(:grade) }

    before :each do
      sign_in current_user
      get journals_path
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }

      it 'show status success' do
        expect(response).to have_http_status(:success)
      end
      it 'show list of classes' do
        expect(response).to render_template("journals/list_of_grades", "layouts/application")
      end
    end

    context 'with logged-in parent' do
      let(:current_user) { parent.user }

      it 'status success' do
        expect(response).to have_http_status(:success)
      end
      it 'show list of parents students' do
        expect(response).to render_template("journals/list_of_students", "layouts/application")
      end
    end

    context 'with logged-in student' do
      let(:current_user) { student.user }

      it 'status 302' do
        expect(response).to have_http_status(302)
      end
      it 'redirects to show page' do
        expect(response).to redirect_to(journal_path(id: student.grade.id))
      end
    end

    context "with not logged-in user" do
      let(:current_user) { 'not_user' }

      it 'status 302' do
        expect(response).to have_http_status(302)
      end
      it 'redirects to show page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:teacher) { create(:teacher) }
    let(:parent) { create(:parent) }
    let!(:student) { create(:student, grade: grade) }
    let!(:grade) { create(:grade) }

    before :each do
      sign_in current_user
      get journal_path(:id)
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }

      it 'show status success' do
        expect(response).to have_http_status(:success)
      end
      it 'show list of classes' do
        expect(response).to render_template("journals/show")
      end
    end

    context 'with logged-in parent' do
      let(:current_user) { parent.user }

      it 'status success' do
        expect(response).to have_http_status(:success)
      end
      it 'show list of parents students' do
        expect(response).to render_template("journals/show")
      end
    end

    context 'with logged-in student' do
      let(:current_user) { student.user }

      it 'status success' do
        expect(response).to have_http_status(:success)
      end
      it 'redirects to show page' do
        expect(response).to render_template("journals/show")
      end
    end

    context "with not logged-in user" do
      let(:current_user) { 'not_user' }

      it 'status 302' do
        expect(response).to have_http_status(302)
      end
      it 'redirects to show page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
