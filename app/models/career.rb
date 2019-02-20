class Career < ApplicationRecord
  include Publishable

  extend FriendlyId
  friendly_id :title, use: :slugged
end
