class Session < ApplicationRecord
  include Publishable

  belongs_to :event, optional: true

  validates :title, presence: true
  validates :author, presence: true
  validates :video_url, presence: true
end
