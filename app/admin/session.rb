ActiveAdmin.register Session do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :description, :author, :video_url, :published
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :title
    column :description
    column :author
    column :video_url
    column :published
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :title
      input :description
      input :video_url
      input :author
      input :published
    end
    actions
  end
end
