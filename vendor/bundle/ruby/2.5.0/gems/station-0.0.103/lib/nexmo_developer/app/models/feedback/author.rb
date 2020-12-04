module Feedback
  class Author < ApplicationRecord
    has_many :feedbacks, as: :owner, dependent: :nullify, inverse_of: :author
  end
end
