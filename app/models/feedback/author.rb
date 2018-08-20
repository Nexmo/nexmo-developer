module Feedback
  class Author < ApplicationRecord
    has_many :feedbacks, as: :owner
  end
end
