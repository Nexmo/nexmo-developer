class Career < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :published, -> { where(published: true) }
end
