class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_image

  validates :title, presence: true
  validates :content, presence: true

  before_save :set_published_at

  scope :published, -> { where(draft: false).where.not(published_at: nil) }
  scope :drafted, -> { where(draft: true) }
  scope :newsletters, -> { where(newsletter_flag: true) }

  def publish!
    update(draft: false, published_at: Time.current)
  end

  def published?
    !draft? && published_at.present?
  end

  private

  def set_published_at
    self.published_at = Time.current if published_at.nil? && !draft?
  end
end
