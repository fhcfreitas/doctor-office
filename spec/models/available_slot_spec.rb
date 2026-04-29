require 'rails_helper'

RSpec.describe AvailableSlot, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(build(:available_slot)).to be_valid
    end

    it "is not valid without a starts_at" do
      expect(build(:available_slot, starts_at: nil)).not_to be_valid
    end

    it "is not valid without an ends_at" do
      expect(build(:available_slot, ends_at: nil)).not_to be_valid
    end

    it "is not valid if ends_at is before starts_at" do
      expect(build(:available_slot, starts_at: 1.hour.from_now, ends_at: 1.hour.ago)).not_to be_valid
    end

    it "is not valid if there is an overlapping slot for the same user" do
      user = create(:user, :admin)
      create(:available_slot, user: user, starts_at: 1.hour.from_now, ends_at: 2.hours.from_now)
      expect(build(:available_slot, user: user, starts_at: 1.5.hours.from_now, ends_at: 2.5.hours.from_now)).not_to be_valid
    end
  end
end
