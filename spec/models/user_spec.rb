require "rails_helper"

RSpec.describe User, type: :model do
  describe "Associations" do
    it { is_expected.to have_many(:addresses).dependent(:destroy) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:rates).dependent(:destroy) }
  end

  describe "Validations" do
    before { FactoryBot.build(:user) }

    context "with name field " do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(Settings.max_256_digest) }
    end

    context "with email field " do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_most(Settings.max_256_digest) }
      it { should allow_value("a@b.c").for(:email) }
      it { should_not allow_value("s").for(:email) }
    end

    context "with password field" do
      it { should validate_length_of(:password).is_at_least(Settings.min_password_length) }
      it { should validate_confirmation_of(:password) }
    end
  end
end
