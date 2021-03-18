require 'rails_helper'

RSpec.describe "Admin::Parents", type: :request do
  let(:parent) { create(:parent) }
  let(:parents) { create_list(:parent, 3) }
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:not_user) { nil }
  let!(:invalid_id) { '998' }
  let(:not_parent) { nil }
  let(:new_user) {create(:user)}

  describe 'GET #index' do
    before(:each) do
      sign_in current_user
      get admin_parents_path
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
      get admin_parent_path(id: parent.id)
    end

    context 'with logged-in admin' do
      let(:current_user) { admin }
      it 'show status' do
        expect(response).to have_http_status(:success)
      end
      it 'should show parent' do
        is_expected.to render_template :show
      end
    end

    context 'does not exist parent' do
      let(:current_user) { admin }
      it { expect { get admin_parent_path(id: invalid_id) }.to raise_error(ActiveRecord::RecordNotFound) }
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
      get new_admin_parent_path
    end

    context 'with logged-in admin' do
      let(:current_user) {admin}
      it 'create a new Parent' do
        expect(assigns(:parent)).to be_a_new(Parent)
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
        before do
          sign_in admin
        end

        it 'redirects to the new parent' do
          expect(post admin_parents_path, params: { parent: { user_id: user.id} })
            .to redirect_to admin_parents_path
        end

        it { expect do
          post admin_parents_path, params: { parent: { user_id: user.id } }
        end.to change(Parent, :count).by(1) }
      end

      context 'with invalid attributes' do
        before do
          sign_in admin
          post admin_parents_path, params: { parent: { parent_id: '' } }
        end

        it 'does not save the new parent' do
          expect { response }.to_not change(Parent, :count)
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
          post admin_parents_path, params: { parent: { parent_id: parent.id } }
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
          post admin_parents_path, params: { parent: { parent_id: parent.id } }
        end
        it { expect(response.status).to eq(302) }
        it { expect(response).to redirect_to new_user_session_path }
      end
    end
  end


  describe 'PATCH #update' do
    before(:each) do
      sign_in current_user
      patch admin_parent_path(id: parent.id), params: { parent: { user_id: current_param } }
      parent.reload
    end

    context 'with logged-in admin' do
      let(:updated_user) {create(:user)}
      let(:current_user) { admin }
      let(:current_param) { updated_user.id }

      context 'valid attributes' do
        it { expect(response).to redirect_to admin_parent_url }
        it { expect(parent.user.full_name).to be_present }
      end

      context 'with invalid attributes' do
        let(:current_param) { '' }

        it 'does not change the parent\'s attributes' do
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
      delete admin_parent_path(id: parent.id)
    end

    context 'with logged-in admin' do
      let!(:new_parent) { create :parent }

      context 'delete from parents table' do
      let(:current_user) { admin }

        it 'delete parent' do
          expect { new_parent.destroy }.to change { Parent.count }.by(-1)
        end

        it 'redirect to index new after destroy' do
          is_expected.to redirect_to admin_parents_path
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
