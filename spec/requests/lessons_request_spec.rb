require 'rails_helper'

RSpec.describe "Lessons", type: :request do
  let(:lesson) { create(:lesson) }
  let(:lessons) { create_list(:lesson, 3) }
  let!(:user) { create(:user) }
  let!(:teacher) { create(:teacher) }
  let!(:invalid_id) { '998' }
  let!(:new_lesson) { create(:lesson) }
  let!(:not_user) { nil }

  describe 'GET #index' do
    before(:each) do
      sign_in current_user
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

    context 'with logged-in user' do
      let(:current_user) { :not_user }

      it 'index status' do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #show' do
    before(:each) do
      sign_in current_user
      get lesson_path(id: lesson.id)
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }

      it 'show status' do
        expect(response).to have_http_status(:success)
      end

      it 'should show teacher' do
        is_expected.to render_template :show
      end
    end

    context 'not teacher' do
      let(:current_user) { teacher.user }

      it { expect { get lesson_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }
    end

    context 'with logged-in user' do
      let(:current_user) { user }

      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET #new' do
    before(:each) do
      sign_in current_user
      get new_lesson_path
    end

    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }

      it 'create a new Lesson' do
        expect(assigns(:lesson)).to be_a_new(Lesson)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'CREATE #create' do
    context 'with logged-in teacher' do
      context 'with valid data' do
        let(:user) {create(:user)}
        let(:grade) {create(:grade)}
        let(:teacher) {create(:teacher)}
        let(:subject) {create(:subject)}
        let(:lesson) {create(:lesson)}

        before do
          sign_in teacher.user
        end

        it { expect do
          post lessons_path, params: { lesson: { teacher_id: teacher.id,
                                                 grade_id: grade.id,
                                                 subject_id: subject.id,
                                                 home_task: Faker::Lorem.sentence(word_count: 3),
                                                 description: Faker::Lorem.sentence(word_count: 5),
                                                 date_at: Faker::Date.forward
          } }
        end.to change(Lesson, :count).by(1) }

        it 'redirects to the new lesson' do
          expect(post lessons_path, params: { lesson:
                                                { teacher_id: teacher.id,
                                                  grade_id: grade.id,
                                                  subject_id: subject.id,
                                                  home_task: Faker::Lorem.sentence(word_count: 3),
                                                  description: Faker::Lorem.sentence(word_count: 5),
                                                  date_at: Faker::Date.forward
                                                } })
            .to redirect_to lessons_path
        end
      end

      context 'with invalid attributes' do
        before do
          sign_in teacher.user
          post lessons_path, params: { lesson: { teacher_id: teacher.id,
                                                 grade_id: 999,
                                                 subject_id: 888,
                                                 home_task: Faker::Lorem.sentence(word_count: 3),
                                                 description: Faker::Lorem.sentence(word_count: 5),
                                                 date_at: Faker::Date.forward
          } }
        end

        it 'does not save the new lesson' do
          expect { response }.to_not change(Lesson, :count)
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
          post lessons_path, params: { lesson: { lesson_id: lesson.id } }
        end
        it 'redirects to root-path' do
          expect(response).to redirect_to root_path
        end
      end
    end
  end

  describe 'PATCH #update' do
    context 'with logged-in teacher' do
      let(:current_user) { teacher.user }
      let(:updated_lesson) {create(:lesson)}
      let(:current_param) { updated_lesson.id }

      context 'valid attributes' do
        before  do
          sign_in current_user
          patch lesson_path(id: lesson.id), params: { lesson: { lesson_id: current_param } }
          lesson.reload
        end

        it { expect(response).to redirect_to lesson_url }
        it { expect(lesson.description).to be_present }
        it { expect(lesson.home_task).to be_present }
        it { expect(lesson.date_at).to be_present }
      end

      context 'with invalid attributes' do
        let(:current_param) { { teacher_id: teacher.id,
                                grade_id: lesson.grade_id,
                                subject_id: lesson.subject_id,
                                home_task: nil,
                                description: lesson.description,
                                date_at: lesson.date_at } }

        before  do
          sign_in current_user
          patch lesson_path(id: lesson.id),
                params: { lesson: current_param  }
          lesson.reload
        end

        it 'does not change the lesson\'s attributes' do
          expect(response).not_to be_redirect
        end

        it 're-renders the edit template' do
          expect(response).to render_template :edit
        end
      end
    end

    context 'with logged-in user' do
      let(:current_user) { user }
      let(:current_param) { new_lesson.id }

      before  do
        sign_in current_user
        patch lesson_path(id: lesson.id), params: { lesson: { lesson_id: current_param } }
        lesson.reload
      end

      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      sign_in current_user
      delete lesson_path(id: lesson.id)
    end

    context 'with logged-in teacher' do
      let!(:new_lesson) { create :lesson }

      context 'delete from lesson table' do
        let(:current_user) { teacher.user }

        it 'delete lesson' do
          expect { new_lesson.destroy }.to change { Lesson.count }.by(-1)
        end

        it 'redirect to index new after destroy' do
          is_expected.to redirect_to lessons_path
        end
      end
    end

    context 'with logged-in user' do
      let(:current_user) { user }

      it 'redirects to root-path' do
        expect(response).to redirect_to root_path
      end
    end
  end
end
