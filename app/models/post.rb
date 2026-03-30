class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :cover_image

  validates :title, presence: true
  validates :content, presence: true

  scope :published, -> { where(draft: false).where.not(published_at: nil) }
  scope :drafted, -> { where(draft: true) }
  scope :newsletters, -> { where(newsletter_flag: true) }

  def publish!
    update(draft: false, published_at: Time.current)
  end
end
