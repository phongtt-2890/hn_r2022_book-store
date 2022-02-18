require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    context "when params id valid" do
      let(:user) {FactoryBot.create :user}

      before do
        get :show, params: {locale: I18n.locale, id: user.id}
      end

      it "should render show" do
        expect(response).to render_template(:show)
      end
    end

    context "when params id invalid" do
      it "should redirect to root" do
        get :show, params: {locale: I18n.locale, id: -1}
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET #new" do
    it "should render new" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when valid params" do
      let(:user) {FactoryBot.attributes_for :user}
      before do
        post :create, params: {locale: I18n.locale, user: user}
      end

      it "should display success flash after create" do
        expect(flash[:success]).to eq I18n.t("create_user_success")
      end

      it "should redirect_to user" do
        expect(response).to redirect_to root_path
      end
    end

    context "when invalid params" do
      before do
        post :create, params: {locale: I18n.locale, user: {name: "", email: ""}}
      end
      it "should display fail flash after create" do
        expect(flash[:danger]).to eq I18n.t("create_user_fail")
      end

      it "should rerender new template" do
        expect(response).to render_template(:new)
      end
    end
  end
end
