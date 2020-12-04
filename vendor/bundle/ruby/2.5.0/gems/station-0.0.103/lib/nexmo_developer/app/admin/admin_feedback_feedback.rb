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

  show do
    attributes_table do
      row :sentiment
      row :resource
      row :owner
      row :owner_type
      row :ip
      row :comment
      row :created_at
      row :updated_at
      row :code_language
      row :code_language_selected_whilst_on_page
      row :code_language_set_by_url
      row :resolved
      row :path
      row :steps do
        if feedback.config
          render 'steps', { feedback: feedback }
        end
      end
    end

    active_admin_comments
  end
end
