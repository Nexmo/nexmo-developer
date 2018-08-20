class Event < ApplicationRecord
  default_scope -> { order(:starts_at) }
  scope :upcoming, -> { where('ends_at > ?', Time.zone.today) }
  scope :past, -> { where('starts_at < ?', Time.zone.today).reverse_order }

  has_many :sessions, dependent: :nullify

  validates :title, presence: true
  validates :description, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
  validates :url, presence: true

  def date_range
    starts = starts_at.strftime('%-d %B %Y')
    ends = ends_at.strftime('%-d %B %Y')
    return starts if starts_at == ends_at
    "#{starts} - #{ends}"
  end
end
