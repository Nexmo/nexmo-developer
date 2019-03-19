ActiveAdmin.register Usage::CodeSnippetEvent do
  permit_params :snippet, :language, :section, :action

  index do
    selectable_column
    id_column
    column :snippet
    column :language
    column :section
    column :action
    column :ip
    actions
  end

  filter :snippet
  filter :language
  filter :section
  filter :action
  filter :ip

  form do |f|
    f.inputs do
      f.input :snippet
      f.input :language
      f.input :section
      f.input :action
      f.input :ip
    end
    f.actions
  end
end
