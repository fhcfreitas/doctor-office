class AvailableSlot < ApplicationRecord
  belongs_to :user

  enum :status, {
    no_show: "no_show",
    available: "available",
    booked: "booked",
    cancelled: "cancelled" }, default: :no_show

  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :status, presence: true
  validate :ends_at_after_starts_at
  validate :no_overlap_for_user

  private

  def ends_at_after_starts_at
    return unless starts_at && ends_at
    errors.add(:ends_at, "deve ser após o início") if ends_at <= starts_at
  end

  def no_overlap_for_user
    return unless starts_at && ends_at && user_id

    overlap = AvailableSlot.where(user_id: user_id)
                           .where.not(id: id)
                           .where(status: [ :available, :booked ])
                           .where("starts_at < ? AND ends_at > ?", ends_at, starts_at)
                           .exists?

    errors.add(:base, "já existe um slot nesse horário") if overlap
  end
end
