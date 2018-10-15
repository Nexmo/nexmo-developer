ActiveAdmin.register Career do
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :summary, :published, :location, :description, :description_short, :url, :icon, :role_group
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :title
    column :summary
    column :published
    column :location
    column :description_short
    column :url
    column :icon
    column :role_group
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :title
      input :summary
      input :published
      input :location
      input :description
      input :description_short
      input :url
      input :icon
      input :role_group
    end
    actions
  end
end
