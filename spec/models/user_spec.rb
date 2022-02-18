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

  describe "class methods" do
    describe ".digest" do
      it "should return passord diget" do
        ActiveModel::SecurePassword.min_cost = false
        expect User.digest("password") != nil
      end

      it "should return passord diget with min_cost" do
        ActiveModel::SecurePassword.min_cost = true
        expect User.digest("password") != nil
      end
    end

    describe ".new_token" do
      it "should return new token" do
        expect User.new_token != nil
      end
    end
  end

  describe "instance methods" do
    let!(:user){FactoryBot.create :user}

    describe "#downcase_email" do
      context "when email has upcase" do
        it "should change email to downcase" do
          user.save
          expect(user.email).to eq user.email.downcase
        end
      end

      context "when email doesn't has upcase" do
        it "should not change email" do
          user.save
          expect(user.email).to eq user.email.downcase
        end
      end
    end

    describe "#remember" do
      it "should return true when update remember digest" do
        expect(user.remember).to eq true
      end
    end

    describe "#authenticated?" do
      it "should returns true when valid remember_token" do
        expect(user.authenticated? "remember_token").to eq true
      end

      it "should returns false when invalid remember_token " do
        expect(user.authenticated? "incorrect_remember_token").to eq false
      end

      it "should returns false when remember_token nil" do
        expect(user.authenticated? nil).to eq false
      end
    end

    describe "#forget" do
      it "should returns true when forget user success" do
        expect user.forget.should eq true
      end
    end
  end
end
