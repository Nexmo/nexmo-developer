module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where(published: true) }
  end

  class_methods do
    def visible_to(user)
      user&.admin? ? all : published
    end
  end
end
