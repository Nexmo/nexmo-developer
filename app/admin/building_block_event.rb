ActiveAdmin.register Usage::BuildingBlockEvent do
  permit_params :block, :language, :section, :action

  index do
    selectable_column
    id_column
    column :block
    column :language
    column :section
    column :action
    column :ip
    actions
  end

  filter :block
  filter :language
  filter :section
  filter :action
  filter :ip

  form do |f|
    f.inputs do
      f.input :block
      f.input :language
      f.input :section
      f.input :action
      f.input :ip
    end
    f.actions
  end
end
