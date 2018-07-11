class Feedback::Author < ApplicationRecord
  has_many :feedbacks, as: :owner
end
