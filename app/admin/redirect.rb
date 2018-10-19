ActiveAdmin.register Redirect do
  permit_params :url, :uses

  index do
    selectable_column
    id_column
    column :url
    column :uses
    actions
  end

  filter :url
  filter :uses

  form do |f|
    f.inputs do
      f.input :url
      f.input :uses
    end
    f.actions
  end
end
