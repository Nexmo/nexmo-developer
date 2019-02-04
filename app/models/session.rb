class Session < ApplicationRecord
  belongs_to :event, optional: true

  validates :title, presence: true
  validates :author, presence: true
  validates :video_url, presence: true

  scope :published, -> { where(published: true) }
end
