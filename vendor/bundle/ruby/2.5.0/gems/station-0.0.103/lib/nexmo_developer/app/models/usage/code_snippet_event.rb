module Usage
  class CodeSnippetEvent < ApplicationRecord
    scope :created_after, ->(date) { where('usage_code_snippet_events.created_at >= ?', date) if date.present? }
    scope :created_before, ->(date) { where('usage_code_snippet_events.created_at <= ?', date) if date.present? }
    scope :created_between, ->(start_date, end_date) { created_after(start_date).created_before(end_date) }
  end
end
