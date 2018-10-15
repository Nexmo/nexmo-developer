json.feedbacks @feedbacks do |feedback|
  json.call(feedback, :id, :sentiment, :resource, :owner, :ip, :comment, :code_language, :code_language_selected_whilst_on_page, :code_language_set_by_url, :created_at, :resolved)
end
