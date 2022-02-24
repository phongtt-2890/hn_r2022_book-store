require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    context "when params id valid" do
      let(:user) {FactoryBot.create :user}

      before do
        sign_in user
        get :show, params: {locale: I18n.locale, id: user.id}
      end

      it "should render show" do
        expect(response).to render_template(:show)
      end
    end

    context "when params id invalid" do
      it "should redirect to login" do
        get :show, params: {locale: I18n.locale, id: -1}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
