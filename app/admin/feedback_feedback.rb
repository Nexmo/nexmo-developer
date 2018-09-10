ActiveAdmin.register ::Feedback::Feedback, as: 'Feedback' do
  menu parent: 'Feedback', priority: 1

  permit_params :resolved

  index do
    column :id do |feedback|
      feedback.id.first(8)
    end
    column :sentiment
    column :resource
    column :owner
    column :ip
    column :comment
    column :code_language
    column :code_language_selected_whilst_on_page
    column :code_language_set_by_url
    column :created_at
    column :resolved
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :resolved
    end
    actions
  end
end
