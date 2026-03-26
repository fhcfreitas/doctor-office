require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without an email address" do
      user.email_address = nil
      expect(user).not_to be_valid
    end

    it "is not valid without a password" do
      user.password = nil
      expect(user).not_to be_valid
    end

    it "is not valid with a duplicate email address" do
      create(:user, email_address: user.email_address)
      expect(user).not_to be_valid
    end

    it "defaults admin to false and responds to admin?" do
      user = User.new
      expect(user).to respond_to(:admin?)
      expect(user.admin?).to be_falsey
    end

    it "returns true for admin user" do
      user = User.new(admin: true)
      expect(user.admin?).to be_truthy
    end
  end
end
